import 'package:demo/src/utils/apiresponse_model.dart';

import '../model/veterinary_model.dart';
import 'veterinary_Api_Service.dart';

class VeterinaryRepository {
  final veterinaryApiService = VeterinaryApiService();
  String accessToken = "";

  Future<ApiResponse> insertVeterinary(Veterinary veterinary) =>
      veterinaryApiService.insertVeterinary(veterinary, accessToken);

  Future<ApiResponse> updateVeterinary(Veterinary veterinary) =>
      veterinaryApiService.updateVeterinary(veterinary, accessToken);

  Future<ApiResponse> findAllVeterinary() =>
      veterinaryApiService.findAllVeterinary(accessToken);

  Future<ApiResponse> getVeterinaryById(int id) =>
      veterinaryApiService.getVeterinaryById(id, accessToken);

  Future<ApiResponse> deleteVeterinary(int id) =>
      veterinaryApiService.deleteVeterinary(id, accessToken);
}
