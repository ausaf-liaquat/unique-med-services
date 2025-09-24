import 'dart:convert';
import 'dart:io';

import 'package:localstorage/localstorage.dart';
import 'package:ums_staff/core/api_response.dart';
import 'package:ums_staff/core/constants.dart';
import 'package:http/http.dart' as http;
import 'package:ums_staff/screens/shift/clinicianTypesModel.dart';

class HttpRequest extends BaseHttpRequest {
  Future<ResponseBody> login(dynamic body) {
    return post('api/v1/auth/login', body, body, true);
  }

  Future<ResponseBody> unreadNotification() {
    return post('api/v1/get/unread/notifications', {"": ""}, null, false);
  }

  Future<ResponseBody> readNotification() {
    return post('api/v1/get/read/notifications', {"": ""}, null, false);
  }

  Future<ResponseBody> markReadNotifications(String id) async {
    var url = Uri.https(Constants.baseUrl, 'api/v1/mark/notification/read');
    var token = await getToken();
    var request = http.MultipartRequest('POST', url);
    Map<String, String> header = {"Authorization": 'Bearer ${token ?? ''}'};
    request.headers.addAll(header);
    request.fields.addAll({"id": id});
    var res = await request.send();
    return await parseResponseForm(res);
  }

  Future<ResponseBody> getShift(dynamic body) {
    return get('api/v1/shifts', body);
  }

  Future<ResponseBody> getProfileData() {
    return post('api/v1/get/user', {"": ""}, null, false);
  }

  Future<ResponseBody> getAcceptShift() {
    return post('api/v1/accepted/shifts/list', {"": ""}, null, false);
  }

  Future<ResponseBody> docType() {
    return post('api/v1/document/types', {"": ""}, null, false);
  }

  Future<ResponseBody> docs() {
    return post('api/v1/user/documents', {"": ""}, null, false);
  }

  Future<ApiResponse> regVerify(dynamic data) async {
    try {
      var url = Uri.https(Constants.baseUrl, 'api/v1/auth/verify');
      var token = await getToken();

      // Use http package for JSON request
      final response = await http.post(
        url,
        headers: {
          "Authorization": 'Bearer ${token ?? ''}',
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(data), // Encode the data as JSON string
      );

      // Parse JSON response
      final responseData = jsonDecode(response.body);

      return ApiResponse(
        success: responseData['status'] == 'success', // Use 'status' not 'success'
        data: responseData,
        message: responseData['message'] ?? '',
      );
    } catch (e) {
      print('regVerify error: $e');
      return ApiResponse(
        success: false,
        message: 'Verification failed: $e',
      );
    }
  }
  Future<ApiResponse> resendVerificationCode(dynamic data) async {
    try {
      var url = Uri.https(Constants.baseUrl, 'api/v1/auth/resend/code');
      var token = await getToken();

      print('🔄 Calling resendVerificationCode endpoint: ${url.toString()}');
      print('📦 Request data: $data');

      final response = await http.post(
        url,
        headers: {
          "Authorization": 'Bearer ${token ?? ''}',
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(data),
      );

      print('📨 Response status: ${response.statusCode}');
      print('📨 Response body: ${response.body}');

      // Check if response is HTML before parsing
      if (response.body.toString().contains('<!DOCTYPE') ||
          response.body.toString().contains('<html>')) {
        return ApiResponse(
          success: false,
          message: 'Server returned HTML error page',
        );
      }

      final responseData = jsonDecode(response.body);

      return ApiResponse(
        success: responseData['status'] == 'success',
        data: responseData,
        message: responseData['message'] ?? '',
      );
    } catch (e) {
      print('resendVerificationCode error: $e');
      return ApiResponse(
        success: false,
        message: 'Failed to resend verification code: $e',
      );
    }
  }
  Future<ResponseBody> shifts() {
    return post('api/v1/shifts', {"": ""}, null, false);
  }

  // shift filters

  shiftFilters({String? date, String? type, String? shift_hour, String? location}) async {
    var token = await getToken();
    var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
    var url = Uri.https(Constants.baseUrl, 'api/v1/shifts/filter');
    var request = http.MultipartRequest('POST', url);

    request.fields.addAll({
      if (date != null) 'date': date,
      if (type != null) 'type': type,
      if (shift_hour != null) 'shift_hour': shift_hour,
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }

    // return post(
    //     'api/v1/shifts/filter',
    //     {
    //       if (date != null) 'date': date,
    //       if (type != null) 'type': type,
    //       if (shift_hour != null) 'shift_hour': shift_hour,
    //       if (location != null) 'location': location,
    //     },
    //     null,
    //     false);
  }

  Future<ResponseBody> getStripLogin() {
    return post('api/v1/stripe/login/connect/account', {"": ""}, null, false);
  }

  Future<ResponseBody> shiftsAccept(String id) {
    return post('api/v1/shift/$id/accept', {"": ""}, null, false);
  }

  Future<ResponseBody> shiftsDecline(String id) {
    print("^^^^^^^^^^^^^^^^^^^^^^ $id");
    return post('api/v1/shift/$id/decline', {"": ""}, null, false);
  }

  Future<ResponseBody> verify(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/v1/auth/password/reset-code/check');
    var token = await getToken();
    var request = http.MultipartRequest('POST', url);
    Map<String, String> header = {"Authorization": 'Bearer ${token ?? ''}'};
    request.headers.addAll(header);
    request.fields.addAll(body);
    var res = await request.send();
    return await parseResponseForm(res);
  }

  Future<ResponseBody> changePassword(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/v1/auth/password/reset');
    var token = await getToken();
    var request = http.MultipartRequest('POST', url);
    Map<String, String> header = {"Authorization": 'Bearer ${token ?? ''}'};
    request.headers.addAll(header);
    request.fields.addAll(body);
    var res = await request.send();
    return await parseResponseForm(res);
  }

  Future<ResponseBody> w9(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/v1/w9/form');
    var token = await getToken();
    var request = http.MultipartRequest('POST', url);
    Map<String, String> header = {"Authorization": 'Bearer ${token ?? ''}'};
    request.headers.addAll(header);
    request.fields.addAll(body);
    var res = await request.send();
    return await parseResponseForm(res);
  }

  Future<ResponseBody> stripRegister(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/v1/stripe/register/connect/account');
    var token = await getToken();
    var request = http.MultipartRequest('POST', url);
    Map<String, String> header = {"Authorization": 'Bearer ${token ?? ''}', 'Accept': "application/json"};
    request.headers.addAll(header);
    request.fields.addAll(body);
    var res = await request.send();
    return await parseResponseForm(res);
  }

  Future<ResponseBody> depositForm(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/v1/deposit/form');
    var token = await getToken();
    var request = http.MultipartRequest('POST', url);
    Map<String, String> header = {"Authorization": 'Bearer ${token ?? ''}'};
    request.headers.addAll(header);
    request.fields.addAll(body);
    var res = await request.send();
    return await parseResponseForm(res);
  }

  Future<ResponseBody> forgetPassword(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/v1/auth/password/reset-code/send');
    var request = http.MultipartRequest('POST', url);
    var token = await getToken();
    Map<String, String> header = {"Authorization": 'Bearer ${token ?? ''}'};
    request.headers.addAll(header);
    request.fields.addAll(body);
    var res = await request.send();
    return await parseResponseForm(res);
  }

  Future<ResponseBody> logout() {
    return post('api/v1/auth/logout', {"": ""}, {"": ""}, false);
  }

  Future<dynamic> updateProfile(Map<String, String> body, {File? imageFile}) async {
    var url = Uri.https(Constants.baseUrl, 'api/v1/user/update');
    var request = http.MultipartRequest('POST', url);

    var token = await getToken();
    Map<String, String> header = {"Authorization": 'Bearer ${token ?? ''}'};
    request.headers.addAll(header);

    // ✅ Add all text fields EXCEPT image
    body.remove('image');
    request.fields.addAll(body);

    // ✅ Only add image if updated
    if (imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
    }

    var res = await request.send();
    return await parseResponseForm(res);
  }

  Future<dynamic> register(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/v1/auth/register');
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll(body);
    if (body['resume'] != null) {
      request.files.add(await http.MultipartFile.fromPath('resume', body['resume']!));
    }
    var res = await request.send();
    return await parseResponseFormRegister(res, true);
  }

  Future<dynamic> uploadDoc(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/v1/documents/upload');
    var request = http.MultipartRequest('POST', url);
    var token = await getToken();
    Map<String, String> header = {"Authorization": 'Bearer ${token ?? ''}'};
    request.headers.addAll(header);
    request.fields.addAll(body);
    if (body['file'] != null) {
      request.files.add(await http.MultipartFile.fromPath('file', body['file']!));
    }
    var res = await request.send();
    return await parseResponseForm(res);
  }

  Future<dynamic> clockin(dynamic body, int id) async {
    var url = Uri.https(Constants.baseUrl, 'api/v1/shift/$id/clockin');
    var request = http.MultipartRequest('POST', url);
    var token = await getToken();
    Map<String, String> header = {"Authorization": 'Bearer ${token ?? ''}'};
    request.headers.addAll(header);
    request.fields.addAll(body);
    var res = await request.send();
    return await parseResponseForm(res);
  }

  Future<dynamic> bca(dynamic body) async {
    var url = Uri.https(Constants.baseUrl, 'api/v1/bca/form');
    var request = http.MultipartRequest('POST', url);
    var token = await getToken();
    Map<String, String> header = {"Authorization": 'Bearer ${token ?? ''}'};
    request.headers.addAll(header);
    request.fields.addAll(body);
    var res = await request.send();
    return await parseResponseForm(res);
  }

  Future<dynamic> clockout(int id) async {
    return post('api/v1/shift/$id/clockout', {"": ""}, null, false);
  }
}

class ResponseBody {
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
    if (body != null) {
      newBody = jsonEncode(body);
    }
    var response = await http.post(url, body: newBody, headers: {"Authorization": 'Bearer ${token ?? ''}', 'Accept': 'application/json'});
    print("dsdasdasda  ${response.body}");
    return parseResponse(response, saveT);
  }

  Future<ResponseBody> get(String urlPath, dynamic qp) async {
    var url = Uri.https(Constants.baseUrl, urlPath, qp);
    var token = await getToken();
    var response = await http.get(url, headers: {"Authorization": 'Bearer ${token ?? ''}'});
    print(response.statusCode);
    return parseResponse(response, false);
  }

  Future<ResponseBody> postWithOutQp(String urlPath, dynamic body, bool saveT) async {
    var url = Uri.https(Constants.baseUrl, urlPath);
    var token = await getToken();
    var newBody = body;
    if (body != null) {
      newBody = jsonEncode(body);
    }
    var response = await http.post(url, body: newBody, headers: {"Authorization": 'Bearer ${token ?? ''}'});
    return parseResponse(response, saveT);
  }

  Future<ResponseBody> parseResponse(dynamic response, bool saveT) async {
    print(response.body);
    var responseBody = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

    if (response.statusCode == 401) {
      clearToken();
      return ResponseBody(success: false, message: responseBody["message"]);
    } else if (response.statusCode == 400 || response.statusCode == 422 || response.statusCode == 403 || response.statusCode == 500) {
      return ResponseBody(success: false, message: responseBody["message"]);
    } else {
      if (saveT) {
        print(responseBody.toString());
        await saveToken(responseBody['data']['token']);
      }
      return ResponseBody(success: true, message: '', data: responseBody);
    }
  }

  Future<ResponseBody> parseResponseFormRegister(http.StreamedResponse response, bool saveAuthToken) async {
    var result = await response.stream.bytesToString();
    print(result.toString());

    var responseBody = jsonDecode(result) as Map;
    if (response.statusCode == 401) {
      clearToken();
      return ResponseBody(success: false, message: responseBody["message"]);
    } else if (response.statusCode == 400 || response.statusCode == 422 || response.statusCode == 403) {
      return ResponseBody(success: false, message: responseBody["message"]);
    } else {
      if (saveAuthToken) {
        print(responseBody.toString());
        await saveToken(responseBody['data']['auth_token']);
      }
      return ResponseBody(success: true, message: '', data: responseBody);
    }
  }

  Future<ResponseBody> parseResponseForm(dynamic response) async {
    var result = await response.stream.bytesToString();
    var responseBody = jsonDecode(result != "" ? result : '{}') as Map;
    if (response.statusCode == 401) {
      clearToken();
      return ResponseBody(success: false, message: responseBody["message"]);
    } else if (response.statusCode == 400 || response.statusCode == 422 || response.statusCode == 403 || response.statusCode == 500) {
      return ResponseBody(success: false, message: responseBody["message"]);
    } else {
      return ResponseBody(success: true, message: '', data: responseBody);
    }
  }

  Future<String> getToken() async {
    final LocalStorage storage = LocalStorage('LocalStorage');
    var value = storage.getItem('token') ?? '';
    return value;
  }

  saveToken(token) async {
    final LocalStorage storage = LocalStorage('LocalStorage');
    storage.setItem('token', token);
  }

  clearToken() {
    final LocalStorage storage = LocalStorage('LocalStorage');
    storage.clear();
  }

  checkToken() {
    final LocalStorage storage = LocalStorage('LocalStorage');
    return storage.getItem('token');
  }
}
