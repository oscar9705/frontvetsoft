import 'package:demo/src/repository/user_Api_Service.dart';
import 'package:demo/src/utils/apiresponse_model.dart';
import 'package:demo/src/model/user_model.dart';

class UserRepository {
  UserApiService userApiService;
  String accessToken;

  validateExpirationSession() {}

  Future<ApiResponse> getAllUsers() => userApiService.getAllUsers(accessToken);

  Future<ApiResponse> getUserById(int id) =>
      userApiService.getUserById(id, accessToken);

  Future<ApiResponse> insertUser(User user) =>
      userApiService.insertUser(user, accessToken);

  Future<ApiResponse> updateUser(User user) =>
      userApiService.updateUser(user, accessToken);

  Future<ApiResponse> deleteUser(int id) =>
      userApiService.deleteUser(id, accessToken);
}
