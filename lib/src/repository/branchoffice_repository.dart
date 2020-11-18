import 'package:demo/src/model/branchoffice_model.dart';
import 'package:demo/src/repository/branchoffice_Api_Service.dart';

import '../utils/apiresponse_model.dart';

class BranchOfficeRepository {
  BranchOfficeApiService branchOfficeApiService;
  String accessToken;

  Future<ApiResponse> getAllBranchOffice() =>
      branchOfficeApiService.getAllBranchOffice(accessToken);

  Future<ApiResponse> getBranchOfficeById(int id) =>
      branchOfficeApiService.getBranchOfficeById(id, accessToken);

  Future<ApiResponse> insertBranchOffice(BranchOffice branchOffice) =>
      branchOfficeApiService.insertBranchOffice(branchOffice, accessToken);

  Future<ApiResponse> updateBranchOffice(BranchOffice branchOffice) =>
      branchOfficeApiService.updateBranchOffice(branchOffice, accessToken);

  Future<ApiResponse> deleteBranchOffice(int id) =>
      branchOfficeApiService.deleteBranchOffice(id, accessToken);
}
