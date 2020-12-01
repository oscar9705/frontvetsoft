import 'dart:convert';

import 'package:demo/src/model/login_model.dart';
import 'package:demo/src/resource/Constants.dart';
import 'package:demo/src/utils/apiresponse_model.dart';
import 'package:demo/src/utils/errorapiresponse_model.dart';
import 'package:http/http.dart' as http;

class LoginApiService {
  Login _login;
  ErrorApiResponse _errorApiResponse;

  Future<ApiResponse> login(Login login) async {
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    var body = json.encode(login.toJson());
    Uri uri = Uri.http(Constants.urlAuthority, Constants.urlLogin);
    var res = await http.post(uri, body: body);

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;
    if (apiResponse.statusResponse == 200) {}
  }
}
