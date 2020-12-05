import 'package:demo/src/model/login_model.dart';
import 'package:demo/src/model/token.model.dart';
import 'package:demo/src/model/user_model.dart';
import 'package:demo/src/repository/general_repository.dart';
import 'package:demo/src/resource/Constants.dart';
import 'package:demo/src/utils/apiresponse_model.dart';
import 'package:demo/src/utils/errorapiresponse_model.dart';
import 'package:demo/src/utils/manage_token.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class LoginBloc {
  final _repository = GeneralRepository();
  BuildContext _context;
  final ManageToken manageToken = ManageToken();
  ProgressDialog _progressDialog;
  ApiResponse _apiResponse = ApiResponse();

  ApiResponse get apiResponse => _apiResponse;

  LoginBloc(BuildContext context) {
    _context = context;
  }

  Future<ApiResponse> login(Login login) async {
    _progressDialog = ProgressDialog(_context,
        type: ProgressDialogType.Normal, isDismissible: false);
    _progressDialog.style(message: "Iniciando sesión");
    await _progressDialog.show();

    ApiResponse apiResponse = await _repository.login(login);
    if (apiResponse.statusResponse == 200) {
      Token token = apiResponse.object;
      _progressDialog.update(message: Constants.loginSuccess);
      manageToken.saveToken(token.token);
      apiResponse.message = Constants.insertSuccess;
    } else {
      _progressDialog.update(message: Constants.loginfailed);
      await _progressDialog.hide();
      ApiResponse error = apiResponse.object;
      error.message = Constants.loginfailed;
    }
    await _progressDialog.hide();
    return apiResponse;
  }

  Future<ApiResponse> register(User user) async {
    _progressDialog = ProgressDialog(_context,
        type: ProgressDialogType.Normal, isDismissible: false);
    _apiResponse = await _repository.register(user);
    _progressDialog.style(message: Constants.registerObject);
    await _progressDialog.show();
    if (_apiResponse.statusResponse == 200) {
      _progressDialog.update(message: Constants.insertSuccess);
      _apiResponse.message = Constants.insertSuccess;
    } else {
      _progressDialog.update(message: Constants.insertError);
      ErrorApiResponse error = _apiResponse.object;
    }
    await _progressDialog.hide();
    return _apiResponse;
  }

  Future<bool> existToken() async {
    bool value = await manageToken.existValueByKey();
    if (value) {
      return true;
    } else {
      return false;
    }
  }

  void closeSession() {
    manageToken.logout();
  }

  @override
  void dispose() {}
}
