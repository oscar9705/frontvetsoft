import 'package:demo/src/resource/Constants.dart';

class ValidatorForms {
  ValidatorForms();
  static String validateUsername(String value) {
    return value == null ? Constants.requireData : null;
  }

  static String validateRequireData(String value) {
    return value.isEmpty ? Constants.requireData : null;
  }

  static String validateNumberInt(String value) {
    if (value.isEmpty) {
      return Constants.requireData;
    } else {
      final RegExp number = RegExp(Constants.expNumbInt);
      if (!number.hasMatch(value)) {
        return "debe de ser númerico ";
      }
    }
    return null;
  }

  static String validateLetter(String value) {
    if (value.isEmpty) {
      return Constants.requireData;
    } else {
      final RegExp letter = RegExp(Constants.expLetter);
      if (!letter.hasMatch(value)) {
        return "debe de ser letras";
      }
    }
    return null;
  }

  static String validatePassword(String value) {
    if (value.isEmpty) {
      return Constants.requireData;
    } else {
      final RegExp letter = RegExp(Constants.expPass);
      if (!letter.hasMatch(value)) {
        return "debe tener al menos, una mayuscula, una minuscula, un número \n y un caracter especial";
      }
    }
    return null;
  }

  static String validateEmail(String value) {
    if (value.isEmpty) {
      return Constants.requireData;
    } else {
      final RegExp email = RegExp(Constants.expEmail);
      if (!email.hasMatch(value)) {
        return "debe de ser un correo válido";
      }
    }
    return null;
  }
}
