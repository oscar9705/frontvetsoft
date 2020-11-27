import 'dart:async';

import 'package:demo/src/repository/veterinary_repository.dart';
import 'package:demo/src/utils/apiresponse_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../model/veterinary_model.dart';

class VeterinaryBloc {
  final _repository = VeterinaryRepository();
  var _apiResponse = ApiResponse();
  BuildContext _context;
  ProgressDialog _progressDialog;
  final _veterinaryListController =
      StreamController<List<Veterinary>>.broadcast();
  final _veterinaryController = StreamController<Veterinary>.broadcast();

  VeterinaryBloc(BuildContext context) {
    _context = context;
    _apiResponse = ApiResponse();
  }
}
