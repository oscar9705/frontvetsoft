import 'dart:async';

import 'package:demo/src/model/appointment_model.dart';
import 'package:demo/src/repository/appointment_respository.dart';
import 'package:demo/src/utils/apiresponse_model.dart';
import 'package:demo/src/utils/errorapiresponse_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:demo/src/resource/Constants.dart';

class AppointmentBloc {
  final _repository = AppointmentRepository();
  var _apiResponse = ApiResponse();

  Appointment _appointment;
  BuildContext _context;
  ErrorApiResponse _error;

  final _appointmentListController =
      StreamController<List<Appointment>>.broadcast();
  final _appointmentController = StreamController<Appointment>.broadcast();
  Stream<List<Appointment>> get appointmentList =>
      _appointmentListController.stream.asBroadcastStream();
  AppointmentBloc(BuildContext context) {
    _context = context;
    _apiResponse = ApiResponse();
  }

  Future<ApiResponse> createAppointment(Appointment appointment) async {
    _apiResponse = await _repository.insertAppointment(appointment);
    if (_apiResponse.statusResponse == 200) {
      _apiResponse.message = Constants.insertSuccess;
    } else {
      _apiResponse.message = Constants.insertError;
    }
    return _apiResponse;
  }

  Future getById(String id) async {
    _apiResponse = await _repository.getAppointmentById(id);
    if (_apiResponse.statusResponse == 200) {
      _appointment = _apiResponse.object;
    } else {
      ErrorApiResponse error = _apiResponse.object;
    }
    return _apiResponse;
  }

  Future<ApiResponse> getAll() async {
    _apiResponse = await _repository.getAllAppointments();
    if (_apiResponse.statusResponse == 200) {
      _appointment = _apiResponse.object;
    } else {
      ErrorApiResponse error = _apiResponse.object;
    }
    return _apiResponse;
  }

  Future<ApiResponse> updateAppointment(Appointment appointment) async {
    _apiResponse = await _repository.updateAppointment(appointment);
    if (_apiResponse.statusResponse == 200) {
      _apiResponse.message = Constants.updateSuccess;
    } else {
      ErrorApiResponse error = _apiResponse.object;
    }
    return _apiResponse;
  }

  Future<ApiResponse> deleteAppointment(String id) async {
    _apiResponse = await _repository.deleteAppointmentById(id);
    if (_apiResponse.statusResponse == 200) {
      _apiResponse.message = Constants.deleteSuccess;
    } else {
      ErrorApiResponse error = _apiResponse.object;
    }
    return _apiResponse;
  }

  void dispose() {
    _appointmentController.close();
    _appointmentListController.close();
  }
}
