import 'package:demo/src/repository/pet_Api_Service.dart';
import 'package:demo/src/utils/apiresponse_model.dart';
import 'package:demo/src/model/pet_model.dart';
import '../model/pet_model.dart';

class PetRepository {
  PetApiService petApiService;
  String accessToken;

  Future<ApiResponse> getAllPet() => petApiService.getAllPet(accessToken);

  Future<ApiResponse> getPetById(int idPet) =>
      petApiService.getPetById(idPet, accessToken);

  Future<ApiResponse> insertPet(Pet pet) =>
      petApiService.insertPet(pet, accessToken);

  Future<ApiResponse> updatePet(Pet pet) =>
      petApiService.updatePet(pet, accessToken);

  Future<ApiResponse> deletePet(int idPet) =>
      petApiService.deletePet(idPet, accessToken);
}
