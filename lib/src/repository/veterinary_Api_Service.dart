import 'dart:convert';
import 'dart:io';
import 'package:demo/src/resource/Constants.dart';
import 'package:demo/src/utils/apiresponse_model.dart';
import 'package:demo/src/utils/errorapiresponse_model.dart';
import 'package:http/http.dart' as http;
import 'package:f_logs/model/flog/flog.dart';
import '../model/veterinary_model.dart';

class VeterinaryApiService {
  Veterinary _veterinary;
  ErrorApiResponse _error;

  VeterinaryApiService();

  Future<ApiResponse> insertVeterinary(
      Veterinary veterinary, String accessToken) async {
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    var body = json.encode(veterinary.toJsonRegistry());
    Uri uri = Uri.http(Constants.urlAuthority, Constants.urlInsertVeterinary);
    var res = await http.post(uri,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer " + accessToken
        },
        body: body);

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;
    if (apiResponse.statusResponse == 200) {
      _veterinary = Veterinary.fromJson(resBody);
      apiResponse.object = _veterinary;
    } else {
      _error = ErrorApiResponse.fromJson(resBody);
      FLog.error(text: _error.toJson().toString());
      apiResponse.object = _error;
    }
    return apiResponse;
  }

  Future<ApiResponse> updateVeterinary(
      Veterinary veterinary, String accessToken) async {
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    var body = json.encode(veterinary.toJson());
    Uri uri = Uri.http(Constants.urlAuthority, Constants.urlUpdateVeterinary);
    var res = await http.put(uri,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer " + accessToken
        },
        body: body);

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;
    if (apiResponse.statusResponse == 200) {
      _veterinary = Veterinary.fromJson(resBody);
      apiResponse.object = _veterinary;
    } else {
      _error = ErrorApiResponse.fromJson(resBody);
      FLog.error(text: _error.toJson().toString());
      apiResponse.object = _error;
    }
    return apiResponse;
  }

  Future<ApiResponse> findAllVeterinary(String accessToken) async {
    List<Veterinary> listVeterinary = List();
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    Uri uri = Uri.http(Constants.urlAuthority, Constants.urlFindAllVeterinarys);
    var res = await http.get(uri,
        headers: {HttpHeaders.authorizationHeader: "Bearer " + accessToken});
    var resBody = json.decode(res.body);

    apiResponse.statusResponse = res.statusCode;

    if (apiResponse.statusResponse == 200) {
      resBody.forEach((i) {
        listVeterinary.add(Veterinary.fromJson(i));
        return i;
      });
      apiResponse.object = listVeterinary;
    } else {
      _error = ErrorApiResponse.fromJson(resBody);
      apiResponse.object = _error;
    }
    return apiResponse;
  }
}
