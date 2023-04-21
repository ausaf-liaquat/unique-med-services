import 'dart:convert';

import 'package:ums_staff/core/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class HttpRequest extends BaseHttpRequest {
  Future<reponceBody> login(dynamic body){
    return post('api/v1/auth/login', body);
  }
}
class reponceBody{
  bool success;
  dynamic data;
  String message;
  reponceBody({required this.success, this.data, required this.message});
}
class BaseHttpRequest {
 Future<reponceBody> post(String urlPath, dynamic body) async {
    var url = Uri.https(Constants.BaseUrl, urlPath);
    var token = await getToken();
    var response = await http.post(url, body: body, headers: {
      "Authorization": 'Bearer ${token ?? ''}'
    });
    var responseBody = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    if( response.statusCode == 401 ){
      clearToken();
      return reponceBody(success: false, message: responseBody["message"]);
    }else  if( response.statusCode == 400 ){
      return reponceBody(success: false, message: responseBody["message"]);
    }else {
      return reponceBody(success: false, message: '', data: responseBody );
    }
  }
  Future<String?> getToken() async{
    AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
    final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
    String? value = await storage.read(key: "token");
    return value;
  }
  saveToken(token){
    AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
    final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
    storage.write(key: "token", value: token);
  }
   clearToken(){
     AndroidOptions getAndroidOptions() => const AndroidOptions(
       encryptedSharedPreferences: true,
     );
     final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
     storage.deleteAll();
   }
}