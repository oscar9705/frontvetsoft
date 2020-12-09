import 'dart:convert';
import 'dart:io';

import 'package:demo/src/model/appointment_model.dart';
import 'package:demo/src/resource/Constants.dart';
import 'package:demo/src/utils/apiresponse_model.dart';
import 'package:demo/src/utils/errorapiresponse_model.dart';
import 'package:f_logs/model/flog/flog.dart';
import 'package:http/http.dart' as http;

class AppointmentApiService {
  Appointment _appointment;
  ErrorApiResponse _error;
  AppointmentApiService();

  Future<ApiResponse> getAllAppointments() async {
    List<Appointment> listAppointments = List();
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    Uri url =
        Uri.http(Constants.urlAuthority, Constants.urlFindAllApponintments);
    var res = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: 'AutorizationHeader'});
    var resBody = json.decode(res.body);

    apiResponse.statusResponse = res.statusCode;

    listAppointments = List();
    if (apiResponse.statusResponse == 200) {
      resBody.forEach((i) {
        listAppointments.add(Appointment.fromJson(i));
      });
      apiResponse.object = listAppointments;
    } else {
      _error = ErrorApiResponse.fromJson(resBody);
      apiResponse.object = _error;
    }
    return apiResponse;
  }

  Future<ApiResponse> insertAppointment(Appointment appointment) async {
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    var body = json.encode(appointment.toJsonRegistry());
    Uri uri = Uri.http(Constants.urlAuthority, Constants.urlInsertApponintment);
    var res = await http.post(uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'AutorizationHeader'
        },
        body: body);

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;
    if (apiResponse.statusResponse == res.statusCode) {
      _appointment = Appointment.fromJson(resBody);
      apiResponse.object = _appointment;
    } else {
      _error = ErrorApiResponse.fromJson(resBody);
      FLog.error(text: _error.toJson().toString());
      apiResponse.object = _error;
    }
    return apiResponse;
  }

  Future<ApiResponse> getAppointmentById(String id) async {
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    Uri url =
        Uri.http(Constants.urlAuthority, Constants.urlFindByIdApponintment);
    var res = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: 'AutorizationHeader'});
    var resBody = json.decode(res.body);

    apiResponse.statusResponse = res.statusCode;

    if (apiResponse.statusResponse == 200) {
      _appointment = Appointment.fromJson(resBody);
      apiResponse.object = _appointment;
    } else {
      _error = ErrorApiResponse.fromJson(resBody);
      apiResponse.object = _error;
    }
    return apiResponse;
  }

  Future<ApiResponse> updateAppointment(Appointment appointment) async {
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    var body = json.encode(appointment.toJson());
    Uri uri = Uri.http(Constants.urlAuthority, Constants.urlUpdateApponintment);
    var res = await http.put(uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'AutorizationHeader'
        },
        body: body);

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;
    if (apiResponse.statusResponse == res.statusCode) {
      _appointment = Appointment.fromJson(resBody);
      apiResponse.object = _appointment;
    } else {
      _error = ErrorApiResponse.fromJson(resBody);
      FLog.error(text: _error.toJson().toString());
      apiResponse.object = _error;
    }
    return apiResponse;
  }

  Future<ApiResponse> deleteAppointmentById(String id) async {
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    Uri url = Uri.http(Constants.urlAuthority, Constants.urlDeleteApponintment);
    var res = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: 'AutorizationHeader'});
    var resBody = json.decode(res.body);

    apiResponse.statusResponse = res.statusCode;

    if (apiResponse.statusResponse == 200) {
      _appointment = Appointment.fromJson(resBody);
      apiResponse.object = _appointment;
    } else {
      _error = ErrorApiResponse.fromJson(resBody);
      apiResponse.object = _error;
    }
    return apiResponse;
  }
}
