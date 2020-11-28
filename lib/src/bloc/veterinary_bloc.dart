import 'dart:async';

import 'package:demo/src/repository/veterinary_repository.dart';
import 'package:demo/src/resource/Constants.dart';
import 'package:demo/src/utils/apiresponse_model.dart';
import 'package:demo/src/utils/errorapiresponse_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../model/veterinary_model.dart';

class VeterinaryBloc {
  final _repository = VeterinaryRepository();
  var _apiResponse = ApiResponse();
  Veterinary _veterinary;
  BuildContext _context;
  ProgressDialog _progressDialog;
  final _veterinaryListController =
      StreamController<List<Veterinary>>.broadcast();
  final _veterinaryController = StreamController<Veterinary>.broadcast();
  Stream<List<Veterinary>> get veterinaryList =>
      _veterinaryListController.stream.asBroadcastStream();
  VeterinaryBloc(BuildContext context) {
    _context = context;
    _apiResponse = ApiResponse();
  }
  Future<ApiResponse> createVeterinary(Veterinary veterinary) async {
    _apiResponse = await _repository.insertVeterinary(veterinary);
    if (_apiResponse.statusResponse == 200) {
      _apiResponse.message = Constants.insertSuccess;
    } else {
      ErrorApiResponse error = _apiResponse.object;
    }
    return _apiResponse;
  }

  Future getById(int id) async {
    _apiResponse = await _repository.getVeterinaryById(id);

    if (_apiResponse.statusResponse == 200) {
      _veterinary = _apiResponse.object;
      _apiResponse.message = Constants.searchSuccess;
    } else {
      ErrorApiResponse error = _apiResponse.object;
    }
    return _apiResponse;
  }

  Future<ApiResponse> updateVeterinary(Veterinary veterinary) async {
    _apiResponse = await _repository.updateVeterinary(veterinary);
    if (_apiResponse.statusResponse == 200) {
      _apiResponse.message = Constants.updateSuccess;
    } else {
      ErrorApiResponse error = _apiResponse.object;
    }
    return _apiResponse;
  }

  void dispose() {}
}
