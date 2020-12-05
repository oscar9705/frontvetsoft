import 'dart:convert';
import 'dart:io';
import 'package:demo/src/model/user_model.dart';
import 'package:demo/src/resource/Constants.dart';
import 'package:demo/src/utils/apiresponse_model.dart';
import 'package:demo/src/utils/errorapiresponse_model.dart';
import 'package:http/http.dart' as http;
import 'package:f_logs/model/flog/flog.dart';

class UserApiService {
  User _user;
  ErrorApiResponse _error;

  Future<ApiResponse> getAllUsers(String accessToken) async {
    List<User> listUsers = List();
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    Uri uri = Uri.http(Constants.urlAuthority, Constants.urlFindAllUsers);
    var res = await http.get(uri,
        headers: {HttpHeaders.authorizationHeader: "Bearer " + accessToken});
    var resBody = json.decode(res.body);

    apiResponse.statusResponse = res.statusCode;

    if (apiResponse.statusResponse == 200) {
      resBody.forEach((i) {
        listUsers.add(User.fromJson(i));
        return i;
      });
      apiResponse.object = listUsers;
    } else {
      _error = ErrorApiResponse.fromJson(resBody);
      apiResponse.object = _error;
    }
    return apiResponse;
  }

  Future<ApiResponse> getUserById(int id, String accessToken) async {
    print(accessToken);
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    var queryParameters = {'id': id.toString()};
    Uri uri = Uri.http(
        Constants.urlAuthority, Constants.urlFindByIdUser, queryParameters);
    var res = await http.get(uri,
        headers: {HttpHeaders.authorizationHeader: "Bearer " + accessToken});

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;
    if (apiResponse.statusResponse == 200) {
      _user = User.fromJson(resBody);
      apiResponse.object = _user;
    } else {
      _error = ErrorApiResponse.fromJson(resBody);
      apiResponse.object = _error;
    }
    return apiResponse;
  }

  Future<ApiResponse> insertUser(User user, String accessToken) async {
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    var body = json.encode(user.toJsonRegistry());
    Uri uri = Uri.http(Constants.urlAuthority, Constants.urlInsertUser);
    var res = await http.post(uri,
        headers: {
          HttpHeaders.contentTypeHeader: Constants.content,
          HttpHeaders.authorizationHeader: "Bearer " + accessToken
        },
        body: body);

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;
    if (apiResponse.statusResponse == 200) {
      _user = User.fromJson(resBody);
      apiResponse.object = _user;
    } else {
      _error = ErrorApiResponse.fromJson(resBody);
      FLog.error(text: _error.toJson().toString());
      apiResponse.object = _error;
    }
    return apiResponse;
  }

  Future<ApiResponse> updateUser(User user, String accessToken) async {
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    var body = json.encode(user.toJson());
    Uri uri = Uri.http(Constants.urlAuthority, Constants.urlUpdateUser);
    var res = await http.put(uri,
        headers: {
          HttpHeaders.contentTypeHeader: Constants.content,
          HttpHeaders.authorizationHeader: "Bearer " + accessToken
        },
        body: body);

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;
    if (apiResponse.statusResponse == 200) {
      _user = User.fromJson(resBody);
      apiResponse.object = _user;
    } else {
      _error = ErrorApiResponse.fromJson(resBody);
      FLog.error(text: _error.toJson().toString());
      apiResponse.object = _error;
    }
    return apiResponse;
  }

  Future<ApiResponse> deleteUser(int id, String accessToken) async {
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    var queryParameters = {'id': id.toString()};
    Uri uri = Uri.http(
        Constants.urlAuthority, Constants.urlDeleteUser, queryParameters);
    var res = await http.delete(uri,
        headers: {HttpHeaders.authorizationHeader: "Bearer " + accessToken});

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;
    if (apiResponse.statusResponse == 200) {
      _user = User.fromJson(resBody);
      apiResponse.object = _user;
    } else {
      _error = ErrorApiResponse.fromJson(resBody);
      apiResponse.object = _error;
    }
    return apiResponse;
  }
}
