import 'dart:async';

import 'package:demo/src/repository/veterinary_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../model/veterinary_model.dart';

class VeterinaryBloc {
  BuildContext _context;
  Veterinary _veterinary;
  ProgressDialog _progressDialog;
  final _repository = VeterinaryRepository();
  final _veterinaryController = StreamController<Veterinary>.broadcast();

  VeterinaryBloc(BuildContext context) {
    _context = context;
    _veterinary = Veterinary();
  }
}
