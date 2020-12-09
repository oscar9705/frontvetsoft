import 'dart:async';

import 'package:demo/src/model/branchoffice_model.dart';
import 'package:demo/src/repository/branchoffice_repository.dart';
import 'package:demo/src/utils/apiresponse_model.dart';
import 'package:demo/src/utils/errorapiresponse_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:demo/src/resource/Constants.dart';

import '../model/branchoffice_model.dart';
import '../repository/branchoffice_repository.dart';

class BranchOfficeBloc {
  final _repository = BranchOfficeRepository();
  var _apiResponse = ApiResponse();

  ErrorApiResponse _error;

  final _branchOfficeListController =
      StreamController<List<BranchOffice>>.broadcast();
  final _branchOfficeController = StreamController<BranchOffice>.broadcast();
  Stream<List<BranchOffice>> get branchOfficeList =>
      _branchOfficeListController.stream.asBroadcastStream();
  BranchOfficeBloc(BuildContext context) {
    _apiResponse = ApiResponse();
  }

  Future<ApiResponse> createBranchOffice(BranchOffice branchOffice) async {
    _apiResponse = await _repository.insertBranchOffice(branchOffice);
    if (_apiResponse.statusResponse == 200) {
      _apiResponse.message = Constants.insertSuccess;
    } else {
      _apiResponse.message = Constants.insertError;
    }
    return _apiResponse;
  }

  Future getById(int id) async {
    _apiResponse = await _repository.getBranchOfficeById(id);
    if (_apiResponse.statusResponse == 200) {
    } else {
      ErrorApiResponse error = _apiResponse.object;
    }
    return _apiResponse;
  }

  Future<ApiResponse> getAll() async {
    _apiResponse = await _repository.getAllBranchOffice();
    if (_apiResponse.statusResponse == 200) {
    } else {
      ErrorApiResponse error = _apiResponse.object;
    }
    return _apiResponse;
  }

  Future<ApiResponse> updateBranchOffice(BranchOffice branchOffice) async {
    _apiResponse = await _repository.updateBranchOffice(branchOffice);
    if (_apiResponse.statusResponse == 200) {
      _apiResponse.message = Constants.updateSuccess;
    } else {
      ErrorApiResponse error = _apiResponse.object;
    }
    return _apiResponse;
  }

  Future<ApiResponse> deleteBranchOffice(int id) async {
    _apiResponse = await _repository.deleteBranchOffice(id);
    if (_apiResponse.statusResponse == 200) {
      _apiResponse.message = Constants.deleteSuccess;
    } else {
      ErrorApiResponse error = _apiResponse.object;
    }
    return _apiResponse;
  }

  void dispose() {
    _branchOfficeController.close();
    _branchOfficeListController.close();
  }
}
