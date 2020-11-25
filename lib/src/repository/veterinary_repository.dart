import 'package:demo/src/utils/apiresponse_model.dart';

import '../model/veterinary_model.dart';
import 'veterinary_Api_Service.dart';

class VeterinaryRepository {
  VeterinaryApiService veterinaryApiService;
  String accessToken;

  Future<ApiResponse> saveVeterinary(Veterinary veterinary) =>
      veterinaryApiService.insertVeterinary(veterinary, accessToken);

  Future<ApiResponse> updateVeterinary(Veterinary veterinary) =>
      veterinaryApiService.updateVeterinary(veterinary, accessToken);

  Future<ApiResponse> findAllVeterinary() =>
      veterinaryApiService.findAllVeterinary(accessToken);

  Future<ApiResponse> findVeterinaryById(int id) =>
      veterinaryApiService.findVeterinaryById(id, accessToken);

  Future<ApiResponse> deleteVeterinary(int id) =>
      veterinaryApiService.deleteVeterinary(id, accessToken);
}
