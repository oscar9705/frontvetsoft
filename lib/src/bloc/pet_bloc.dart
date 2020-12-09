import 'dart:async';

import 'package:demo/src/model/pet_model.dart';
import 'package:demo/src/repository/general_repository.dart';
import 'package:demo/src/resource/Constants.dart';
import 'package:demo/src/utils/apiresponse_model.dart';
import 'package:demo/src/utils/errorapiresponse_model.dart';
import 'package:f_logs/model/flog/flog.dart';
import '../model/pet_model.dart';

class PetBloc {
  Pet _pet;
  final _repository = GeneralRepository();
  var _apiResponse = ApiResponse();
  final _petController = StreamController<Pet>.broadcast();
  final _petListController = StreamController<List<Pet>>.broadcast();

  List<Pet> _initialList;
  Stream<Pet> get pet => _petController.stream;
  Stream<List<Pet>> get petList => _petListController.stream;

  ApiResponse get apiResponse => _apiResponse;
  PetBloc();

  Future initializeData() async {
    ApiResponse apiResponse = await _repository.getAllPet();
    if (apiResponse.statusResponse == 200) {
      _initialList = apiResponse.object;
      _petListController.add(_initialList);
    } else {
      ErrorApiResponse error = apiResponse.object;
    }
    return apiResponse;
  }

  Future<ApiResponse> createPet(Pet pet) async {
    ApiResponse apiResponse = await _repository.insertPet(pet);
    if (apiResponse.statusResponse == 200) {
      apiResponse.message = Constants.insertSuccess;
    } else {
      ErrorApiResponse error = apiResponse.object;
    }
    return apiResponse;
  }

  Future getPetById(int idPet) async {
    ApiResponse apiResponse = await _repository.getPetById(idPet);
    if (apiResponse.statusResponse == 200) {
      Pet pet = apiResponse.object;
      _petController.add(pet);
    } else {
      ErrorApiResponse error = apiResponse.object;
      FLog.error(text: error.message);
    }
    return apiResponse;
  }

  Future<ApiResponse> updatePet(Pet pet) async {
    ApiResponse apiResponse = await _repository.updatePet(pet);
    if (apiResponse.statusResponse == 200) {
      apiResponse.message = Constants.updateSuccess;
    } else {
      ErrorApiResponse error = apiResponse.object;
      FLog.error(text: error.message);
    }
    return apiResponse;
  }

  Future<ApiResponse> deletePet(int idPet) async {
    _apiResponse = await _repository.deletePet(idPet);
    if (_apiResponse.statusResponse == 200) {
      _apiResponse.message = Constants.deleteSuccess;
    } else {
      ErrorApiResponse error = _apiResponse.object;
      FLog.error(text: error.message);
    }
    return _apiResponse;
  }

  void dispose() {
    _petListController.close();
    _petController.close();
  }
}
