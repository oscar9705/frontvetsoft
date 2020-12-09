import 'dart:convert';
import 'dart:io';

import 'package:demo/src/model/login_model.dart';
import 'package:demo/src/model/token.model.dart';
import 'package:demo/src/model/user_model.dart';
import 'package:demo/src/resource/Constants.dart';
import 'package:demo/src/utils/apiresponse_model.dart';
import 'package:demo/src/utils/errorapiresponse_model.dart';
import 'package:http/http.dart' as http;

class LoginApiService {
  Token _token = Token();
  User _user = User();
  // ignore: unused_field
  ErrorApiResponse _error;

  Future<ApiResponse> login(Login login) async {
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    var body = json.encode(login.toJson());
    Uri uri = Uri.http(Constants.urlAuthority, Constants.urlLogin);
    var res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json; charset=utf-8'},
      body: body,
    );

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;
    if (apiResponse.statusResponse == 200) {
      _token = Token.fromJson(resBody);
      apiResponse.object = _token;
    } else {
      _error = ErrorApiResponse.fromJson(resBody);
    }
    return apiResponse;
  }

  Future<ApiResponse> register(User user) async {
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    var body = json.encode(user.toJsonRegistry());
    Uri uri = Uri.http(Constants.urlAuthority, Constants.urlRegister);
    var res = await http.post(
      uri,
      headers: {HttpHeaders.contentTypeHeader: Constants.content},
      body: body,
    );

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;
    if (apiResponse.statusResponse == 200) {
      _user = User.fromJson(resBody);
      apiResponse.object = _user;
    } else {
      _error = ErrorApiResponse.fromJson(resBody);
    }
    return apiResponse;
  }
}
