import 'dart:async';
import 'dart:io';

import 'package:demo/src/model/appointment_model.dart';
import 'package:demo/src/repository/appointment_respository.dart';
import 'package:demo/src/utils/apiresponse_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';

class AppointmentBloc {
  final _repository = AppointmentRepository();
  var _apiResponse = ApiResponse();

  Appointment _appointment;
  BuildContext _context;
  ProgressDialog _progressDialog;
  final _appointmentListController =
      StreamController<List<Appointment>>.broadcast();
  final _appointmentController = StreamController<Appointment>.broadcast();
  Stream<List<Appointment>> get appointmentList =>
      _appointmentListController.stream.asBroadcastStream();
  AppointmentBloc(BuildContext context) {
    _context = context;
    _apiResponse = ApiResponse();
  }
}
