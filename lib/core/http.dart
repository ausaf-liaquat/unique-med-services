import 'dart:convert';

import 'package:ums_staff/core/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
 class HttpRequest extends BaseHttpRequest {
  Future<ResponseBody> login(dynamic body){
    var email = body['email'];
    var password = body['password'];
    return post('api/v1/auth/login', body, body);
  }
  Future<ResponseBody> verify(dynamic body){
    return post('api/v1/auth/verify', body, {});
  }
  Future<ResponseBody> forgetPassword(dynamic body){
    return post('api/v1/auth/forget-password', body, {});
  }
  Future<dynamic> register(dynamic body) async {
    var url = Uri.https(Constants.BaseUrl, 'api/v1/auth/register');
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll(body);
    request.files.add(http.MultipartFile.fromString('resume', body['resume']!));
    var res = await request.send();
    return await parseResponseFormRegister(res);
  }
}
class ResponseBody{
  bool success;
  dynamic data;
  String message;
  ResponseBody({required this.success, this.data, required this.message});
}
class BaseHttpRequest {
 Future<ResponseBody> post(String urlPath, dynamic body, dynamic qp) async {
   var url = Uri.https(Constants.BaseUrl, urlPath, qp);
   var token = await getToken();
   var newBody = body;
   if( body != null ){
     newBody = jsonEncode(body);
   }
   var response = await http.post(url, body: newBody, headers: {
     "Authorization": 'Bearer ${token ?? ''}'
   });
   return parseResponse(response);
 }
 ResponseBody parseResponse(dynamic response){
   var responseBody = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
   if( response.statusCode == 401 ){
     clearToken();
     return ResponseBody(success: false, message: responseBody["message"]);
   }else  if( response.statusCode == 400 || response.statusCode == 422 ||  response.statusCode == 403 ){
     return ResponseBody(success: false, message: responseBody["message"]);
   }else {
     saveToken(responseBody['data']['auth_token']);
     return ResponseBody(success: true, message: '', data: responseBody );
   }
 }
 Future<ResponseBody> parseResponseFormRegister(dynamic response) async {
   var result = await response.stream.bytesToString();
   var responseBody = jsonDecode(result) as Map;
   if( response.statusCode == 401 ){
     clearToken();
     return ResponseBody(success: false, message: responseBody["message"]);
   }else  if( response.statusCode == 400 || response.statusCode == 422 ||  response.statusCode == 403 ){
     return ResponseBody(success: false, message: responseBody["message"]);
   }else {
      saveToken(responseBody['data']['auth_token']);
     return ResponseBody(success: true, message: '', data: responseBody );
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