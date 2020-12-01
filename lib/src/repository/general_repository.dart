import 'package:demo/src/model/login_model.dart';
import 'package:demo/src/model/user_model.dart';
import 'package:demo/src/repository/login_Api_Service.dart';
import 'package:demo/src/utils/apiresponse_model.dart';

class GeneralRepository {
  final loginApiService = LoginApiService();

  Future<ApiResponse> login(Login login) => loginApiService.login(login);
  Future<ApiResponse> register(User user) => loginApiService.register(user);
}
