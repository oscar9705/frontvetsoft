import 'dart:async';

import 'package:demo/src/model/user_model.dart';
import 'package:demo/src/repository/general_repository.dart';
import 'package:demo/src/resource/Constants.dart';
import 'package:demo/src/utils/apiresponse_model.dart';
import 'package:demo/src/utils/errorapiresponse_model.dart';
import 'package:f_logs/model/flog/flog.dart';

class UserBloc {
  User _user;
  final _repository = GeneralRepository();
  var _apiResponse = ApiResponse();
  final _userController = StreamController<User>.broadcast();
  final _userListController = StreamController<List<User>>.broadcast();

  List<User> _initialList;

  Stream<User> get userStream => _userController.stream;
  Stream<List<User>> get userList => _userListController.stream;

  Function(User) get addUserStream => _userController.sink.add;
  Function(List<User>) get addUserListStream => _userListController.sink.add;

  ApiResponse get apiResponse => _apiResponse;

  UserBloc();

  Future<ApiResponse> initializeData() async {
    ApiResponse apiResponse = await _repository.getAllUsers();
    if (apiResponse.statusResponse == 200) {
      _initialList = apiResponse.object;
      _userListController.add(_initialList);
    } else {
      ErrorApiResponse error = apiResponse.object;
    }
    return apiResponse;
  }

  Future<ApiResponse> createUser(User user) async {
    ApiResponse apiResponse = await _repository.insertUser(user);
    if (apiResponse.statusResponse == 200) {
      apiResponse.message = Constants.insertSuccess;
    } else {
      ErrorApiResponse error = apiResponse.object;
      FLog.error(text: error.message);
    }
    return apiResponse;
  }

  Future<ApiResponse> updateUser(User user) async {
    ApiResponse apiResponse = await _repository.updateUser(user);
    if (apiResponse.statusResponse == 200) {
      apiResponse.message = Constants.updateSuccess;
    } else {
      _apiResponse = apiResponse;
      ErrorApiResponse error = apiResponse.object;
      FLog.error(text: error.message);
    }
    return apiResponse;
  }

  Future<ApiResponse> getUserById(int id) async {
    ApiResponse apiResponse = await _repository.getUserById(id);
    if (apiResponse.statusResponse == 200) {
      User user = apiResponse.object;
      addUserStream(user);
    } else {
      ErrorApiResponse error = apiResponse.object;
    }
    return apiResponse;
  }

  Future<ApiResponse> getUserByEmail() async {
    ApiResponse apiResponse = await _repository.getUserByEmail();
    if (apiResponse.statusResponse == 200) {
      User user = apiResponse.object;
      addUserStream(user);
    } else {
      ErrorApiResponse error = apiResponse.object;
    }
    return apiResponse;
  }

  void dispose() {
    _userController?.close();
  }
}
