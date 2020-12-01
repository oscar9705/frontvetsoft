import 'package:demo/src/model/login_model.dart';
import 'package:demo/src/model/user_model.dart';
import 'package:demo/src/repository/general_repository.dart';
import 'package:demo/src/resource/Constants.dart';
import 'package:demo/src/utils/apiresponse_model.dart';
import 'package:demo/src/utils/errorapiresponse_model.dart';

class LoginBloc {
  final _repository = GeneralRepository();
  ApiResponse _apiResponse = ApiResponse();

  ApiResponse get apiResponse => _apiResponse;

  LoginBloc() {}

  Future<ApiResponse> login(Login login) async {
    ApiResponse apiResponse = await _repository.login(login);
    if (apiResponse.statusResponse == 200) {
      apiResponse.message = Constants.insertSuccess;
    } else {
      ErrorApiResponse error = apiResponse.object;
    }
    return apiResponse;
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

  @override
  void dispose() {}
}
