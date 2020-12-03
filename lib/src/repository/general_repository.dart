import 'package:demo/src/model/login_model.dart';
import 'package:demo/src/model/user_model.dart';
import 'package:demo/src/repository/login_Api_Service.dart';
import 'package:demo/src/utils/apiresponse_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GeneralRepository {
  final loginApiService = LoginApiService();
  final sessionStorage = FlutterSecureStorage();
  Future<ApiResponse> login(Login login) => loginApiService.login(login);
  Future<ApiResponse> register(User user) => loginApiService.register(user);
}
