import 'package:demo/src/resource/Constants.dart';

class ValidatorForms {
  ValidatorForms() {}
  String validateUsername(String value) {
    return value == null ? Constants.requireData : null;
  }
}
