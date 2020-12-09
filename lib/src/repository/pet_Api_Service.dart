import 'dart:convert';
import 'dart:io';
import 'package:demo/src/model/pet_model.dart';
import 'package:demo/src/resource/Constants.dart';
import 'package:demo/src/utils/apiresponse_model.dart';
import 'package:demo/src/utils/errorapiresponse_model.dart';
import 'package:demo/src/utils/manage_token.dart';
import 'package:http/http.dart' as http;
import 'package:f_logs/model/flog/flog.dart';
import '../model/pet_model.dart';

class PetApiService {
  Pet _pet;
  ErrorApiResponse _error;
  ManageToken manageToken = ManageToken();

  Future<ApiResponse> getAllPet(String accessToken) async {
    String toke = await manageToken.getValueToken();
    List<Pet> listPets = List();
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    Uri uri = Uri.http(Constants.urlAuthority, Constants.urlFindAllPets);
    var res = await http
        .get(uri, headers: {HttpHeaders.authorizationHeader: 'Bearer ' + toke});
    var resBody = json.decode(res.body);

    apiResponse.statusResponse = res.statusCode;

    if (apiResponse.statusResponse == 200 || res.statusCode == 200) {
      resBody.forEach((i) {
        listPets.add(Pet.fromJson(i));
        return i;
      });
      apiResponse.object = listPets;
    } else {
      _error = ErrorApiResponse.fromJson(resBody);
      apiResponse.object = _error;
    }
    return apiResponse;
  }

  Future<ApiResponse> getPetById(int idPet, String accessToken) async {
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    var queryParameters = {'id': idPet.toString()};
    Uri uri = Uri.http(Constants.urlAuthority,
        Constants.pathBase + Constants.urlFindByIdPet, queryParameters);
    var res = await http.get(uri,
        headers: {HttpHeaders.authorizationHeader: "Bearer " + accessToken});

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;
    if (apiResponse.statusResponse == 200) {
      _pet = Pet.fromJson(resBody);
      apiResponse.object = _pet;
    } else {
      _error = ErrorApiResponse.fromJson(resBody);
      apiResponse.object = _error;
    }
    return apiResponse;
  }

  Future<ApiResponse> insertPet(Pet pet, String accessToken) async {
    String toke = await manageToken.getValueToken();
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    var body = json.encode(pet.toJsonRegistry());
    Uri uri = Uri.http(Constants.urlAuthority, Constants.urlInsertPet);
    var res = await http.post(uri,
        headers: {
          HttpHeaders.contentTypeHeader: Constants.content,
          HttpHeaders.authorizationHeader: "Bearer " + toke
        },
        body: body);

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;
    if (apiResponse.statusResponse == 200 || res.statusCode == 200) {
      _pet = Pet.fromJson(resBody);
      apiResponse.object = _pet;
    } else {
      _error = ErrorApiResponse.fromJson(resBody);
      FLog.error(text: _error.toJson().toString());
      apiResponse.object = _error;
    }
    return apiResponse;
  }

  Future<ApiResponse> updatePet(Pet pet, String accessToken) async {
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    var body = json.encode(pet.toJson());
    Uri uri = Uri.http(
        Constants.urlAuthority, Constants.pathBase + Constants.urlUpdateUser);
    var res = await http.put(uri,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer " + accessToken
        },
        body: body);

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;
    if (apiResponse.statusResponse == 200) {
      _pet = Pet.fromJson(resBody);
      apiResponse.object = _pet;
    } else {
      _error = ErrorApiResponse.fromJson(resBody);
      FLog.error(text: _error.toJson().toString());
      apiResponse.object = _error;
    }
    return apiResponse;
  }

  Future<ApiResponse> deletePet(int idPet, String accessToken) async {
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    var queryParameters = {'id': idPet.toString()};
    Uri uri = Uri.http(Constants.urlAuthority,
        Constants.pathBase + Constants.urlDeleteUser, queryParameters);
    var res = await http.delete(uri,
        headers: {HttpHeaders.authorizationHeader: "Bearer " + accessToken});

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;
    if (apiResponse.statusResponse == 200) {
      _pet = Pet.fromJson(resBody);
      apiResponse.object = _pet;
    } else {
      _error = ErrorApiResponse.fromJson(resBody);
      apiResponse.object = _error;
    }
    return apiResponse;
  }
}
