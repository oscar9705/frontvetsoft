import 'package:demo/src/model/login_model.dart';
import 'package:demo/src/model/user_model.dart';
import 'package:demo/src/repository/general_repository.dart';
import 'package:demo/src/resource/Constants.dart';
import 'package:demo/src/utils/apiresponse_model.dart';
import 'package:demo/src/utils/errorapiresponse_model.dart';

class LoginBloc {
  final _repository = GeneralRepository();
  var _apiResponse = ApiResponse();

  LoginBloc() {}

  Future<ApiResponse> login(Login login) async {
    _apiResponse = await _repository.login(login);
    if (_apiResponse.statusResponse == 200) {
      _apiResponse.message = Constants.insertSuccess;
    } else {
      ErrorApiResponse error = _apiResponse.object;
    }
    return _apiResponse;
  }

  Future<ApiResponse> register(User user) async {
    _apiResponse = await _repository.register(user);
    if (_apiResponse.statusResponse == 200) {
      _apiResponse.message = Constants.insertSuccess;
    } else {
      ErrorApiResponse error = _apiResponse.object;
    }
    return _apiResponse;
  }
}
