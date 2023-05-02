import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:ums_staff/core/constants.dart';
import 'package:http/http.dart' as http;
 class HttpRequest extends BaseHttpRequest {
  Future<ResponseBody> login(dynamic body){
    return post('api/v1/auth/login', body, body, true);
  }
  Future<ResponseBody> getShift(dynamic body){
    return get('api/v1/shifts', body);
  }
  Future<ResponseBody> docType(){
    return post('api/v1/document/types', {"": ""}, null, false);
  }
  Future<ResponseBody> docs(){
    return post('api/v1/user/documents', {"": ""}, null, false);
  }
  Future<ResponseBody> shifts(){
    return post('api/v1/shifts', {"": ""}, null, false);
  }
  Future<ResponseBody> shiftsAccept(String id){
    return post('api/v1/shift/$id/accept', {"": ""}, null, false);
  }
  Future<ResponseBody> shiftsDecline(String id){
    return post('api/v1/shift/$id/accept', {"": ""}, null, false);
  }
  Future<ResponseBody> verify(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/v1/auth/password/reset-code/check');
    var token = await getToken();
    var request = http.MultipartRequest('POST', url);
    Map<String, String>  header = { "Authorization": 'Bearer ${token ?? ''}'};
    request.headers.addAll(header);
    request.fields.addAll(body);
    var res = await request.send();
    return await parseResponseForm(res);
  }
  Future<ResponseBody> changePassword(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/v1/auth/password/reset');
    var token = await getToken();
    var request = http.MultipartRequest('POST', url);
    Map<String, String>  header = { "Authorization": 'Bearer ${token ?? ''}'};
    request.headers.addAll(header);
    request.fields.addAll(body);
    var res = await request.send();
    return await parseResponseForm(res);
  }
  Future<ResponseBody> w9(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/v1/w9/form');
    var token = await getToken();
    var request = http.MultipartRequest('POST', url);
    Map<String, String>  header = { "Authorization": 'Bearer ${token ?? ''}'};
    request.headers.addAll(header);
    request.fields.addAll(body);
    var res = await request.send();
    return await parseResponseForm(res);
  }
  Future<ResponseBody> depositForm(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/v1/deposit/form');
    var token = await getToken();
    var request = http.MultipartRequest('POST', url);
    Map<String, String>  header = { "Authorization": 'Bearer ${token ?? ''}'};
    request.headers.addAll(header);
    request.fields.addAll(body);
    var res = await request.send();
    return await parseResponseForm(res);
  }
  Future<ResponseBody> forgetPassword(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/v1/auth/password/reset-code/send');
    var request = http.MultipartRequest('POST', url);
    var token = await getToken();
    Map<String, String>  header = { "Authorization": 'Bearer ${token ?? ''}'};
    request.headers.addAll(header);
    request.fields.addAll(body);
    var res = await request.send();
    return await parseResponseForm(res);
  }

  Future<ResponseBody> logout(){
    return post('api/v1/auth/logout', {"": ""}, {"": ""}, false);
  }
  Future<dynamic> register(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/v1/auth/register');
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll(body);
    if( body['resume'] != null){
      request.files.add( await http.MultipartFile.fromPath('resume', body['resume']!));
    }
    var res = await request.send();
    return await parseResponseFormRegister(res, true);
  }
  Future<dynamic> uploadDoc(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/v1/documents/upload');
    var request = http.MultipartRequest('POST', url);
    var token = await getToken();
    Map<String, String>  header = { "Authorization": 'Bearer ${token ?? ''}'};
    request.headers.addAll(header);
    request.fields.addAll(body);
    if( body['file'] != null){
      request.files.add( await http.MultipartFile.fromPath('file', body['file']!));
    }
    var res = await request.send();
    return await parseResponseForm(res);
  }
}
class ResponseBody{
  bool success;
  dynamic data;
  String message;
  ResponseBody({required this.success, this.data, required this.message});
}
class BaseHttpRequest {
 Future<ResponseBody> post(String urlPath, dynamic body, dynamic qp, bool saveT) async {
   var url = Uri.https(Constants.baseUrl, urlPath, qp);
   var token = await getToken();
   var newBody = body;
   if( body != null ){
     newBody = jsonEncode(body);
   }
   var response = await http.post(url, body: newBody, headers: {
     "Authorization": 'Bearer ${token ?? ''}'
   });
   return parseResponse(response, saveT);
 }
 Future<ResponseBody> get(String urlPath, dynamic qp) async {
   var url = Uri.https(Constants.baseUrl, urlPath, qp);
   var token = await getToken();
   var response = await http.get(url, headers: {
     "Authorization": 'Bearer ${token ?? ''}'
   });
   return parseResponse(response, false);
 }
 Future<ResponseBody> postWithOutQp(String urlPath, dynamic body, bool saveT) async {
   var url = Uri.https(Constants.baseUrl, urlPath);
   var token = await getToken();
   var newBody = body;
   if( body != null ){
     newBody = jsonEncode(body);
   }
   var response = await http.post(url, body: newBody, headers: {
     "Authorization": 'Bearer ${token ?? ''}'
   });
   return parseResponse(response, saveT);
 }
 Future<ResponseBody> parseResponse(dynamic response, bool saveT) async {
   var responseBody = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
   if( response.statusCode == 401 ){
     clearToken();
     return ResponseBody(success: false, message: responseBody["message"]);
   }else  if( response.statusCode == 400 || response.statusCode == 422 ||  response.statusCode == 403 ){
     return ResponseBody(success: false, message: responseBody["message"]);
   }else {
     if(saveT){
       print(responseBody.toString());
       await saveToken(responseBody['data']['token']);
     }
     return ResponseBody(success: true, message: '', data: responseBody );
   }
 }
 Future<ResponseBody> parseResponseFormRegister(dynamic response, bool saveAuthToken ) async {
   var result = await response.stream.bytesToString();
   var responseBody = jsonDecode(result) as Map;
   if( response.statusCode == 401 ){
     clearToken();
     return ResponseBody(success: false, message: responseBody["message"]);
   }else  if( response.statusCode == 400 || response.statusCode == 422 ||  response.statusCode == 403 ){
     return ResponseBody(success: false, message: responseBody["message"]);
   }else {
     if(saveAuthToken){
       print(responseBody.toString());
       await saveToken(responseBody['data']['auth_token']);
     }
     return ResponseBody(success: true, message: '', data: responseBody );
   }
 }
 Future<ResponseBody> parseResponseForm(dynamic response ) async {
   var result = await response.stream.bytesToString();
   var responseBody = jsonDecode(result) as Map;
   if( response.statusCode == 401 ){
     clearToken();
     return ResponseBody(success: false, message: responseBody["message"]);
   }else  if( response.statusCode == 400 || response.statusCode == 422 ||  response.statusCode == 403 ){
     return ResponseBody(success: false, message: responseBody["message"]);
   }else {
     return ResponseBody(success: true, message: '', data: responseBody );
   }
 }
  Future<String?> getToken() async{
    final LocalStorage storage = LocalStorage('LocalStorage');
    var value = storage.getItem('token');
    print('aaaaa');
    print(value);
    print('aaaaa');
    return value;
  }
  saveToken(token) async {
    print('token');
    print(token);
    final LocalStorage storage = LocalStorage('LocalStorage');
    storage.setItem('token', token);
  }
   clearToken(){
     final LocalStorage storage = LocalStorage('LocalStorage');
     storage.clear();
   }
}