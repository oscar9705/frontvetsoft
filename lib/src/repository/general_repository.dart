import 'package:demo/src/model/login_model.dart';
import 'package:demo/src/model/pet_model.dart';
import 'package:demo/src/model/user_model.dart';
import 'package:demo/src/repository/login_Api_Service.dart';
import 'package:demo/src/repository/pet_Api_Service.dart';
import 'package:demo/src/repository/user_Api_Service.dart';
import 'package:demo/src/utils/apiresponse_model.dart';
import 'package:demo/src/utils/manage_token.dart';

class GeneralRepository with ManageToken {
  final petApiService = PetApiService();
  final loginApiService = LoginApiService();
  final userApiService = UserApiService();

  //Auth

  Future<ApiResponse> login(Login login) => loginApiService.login(login);
  Future<ApiResponse> register(User user) => loginApiService.register(user);

  //User

  Future<ApiResponse> getAllUsers() =>
      userApiService.getAllUsers(accessTokenSesion);

  Future<ApiResponse> getUserById(int id) =>
      userApiService.getUserById(id, accessTokenSesion);
  Future<ApiResponse> getUserByEmail() =>
      userApiService.getUserByEmail(accessEmail, accessTokenSesion);
  Future<ApiResponse> insertUser(User user) =>
      userApiService.insertUser(user, accessTokenSesion);

  Future<ApiResponse> updateUser(User user) =>
      userApiService.updateUser(user, accessTokenSesion);

  Future<ApiResponse> deleteUser(int id) =>
      userApiService.deleteUser(id, accessTokenSesion);

  //pet
  Future<ApiResponse> getAllPet() => petApiService.getAllPet(accessTokenSesion);

  Future<ApiResponse> getPetById(int idPet) =>
      petApiService.getPetById(idPet, accessTokenSesion);

  Future<ApiResponse> insertPet(Pet pet) =>
      petApiService.insertPet(pet, accessTokenSesion);

  Future<ApiResponse> updatePet(Pet pet) =>
      petApiService.updatePet(pet, accessTokenSesion);

  Future<ApiResponse> deletePet(int idPet) =>
      petApiService.deletePet(idPet, accessTokenSesion);
}
