import 'package:demo/src/model/branchoffice_model.dart';
import 'package:f_logs/model/flog/flog.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../resource/Constants.dart';
import '../utils/apiresponse_model.dart';
import '../utils/errorapiresponse_model.dart';

class BranchOfficeApiService {
  BranchOffice _branchOffice;
  ErrorApiResponse _error;

  Future<ApiResponse> getAllBranchOffice(String accessToken) async {
    List<BranchOffice> listBranch = List();
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    Uri uri =
        Uri.http(Constants.urlAuthority, Constants.urlFindAllBranchOffices);
    var res = await http.get(uri,
        headers: {HttpHeaders.authorizationHeader: "Bearer " + accessToken});
    var resBody = json.decode(res.body);

    apiResponse.statusResponse = res.statusCode;

    if (apiResponse.statusResponse == 200) {
      resBody.forEach((i) {
        listBranch.add(BranchOffice.fromJson(i));
        return i;
      });
      apiResponse.object = listBranch;
    } else {
      _error = ErrorApiResponse.fromJson(resBody);
      apiResponse.object = _error;
    }
    return apiResponse;
  }

  Future<ApiResponse> getBranchOfficeById(int id, String accessToken) async {
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    var queryParameters = {'id': id.toString()};
    Uri uri = Uri.http(Constants.urlAuthority,
        Constants.urlFindByIdBranchOffice, queryParameters);
    var res = await http.get(uri,
        headers: {HttpHeaders.authorizationHeader: "Bearer " + accessToken});

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;
    if (apiResponse.statusResponse == 200) {
      _branchOffice = BranchOffice.fromJson(resBody);
      apiResponse.object = _branchOffice;
    } else {
      _error = ErrorApiResponse.fromJson(resBody);
      apiResponse.object = _error;
    }
    return apiResponse;
  }

  Future<ApiResponse> insertBranchOffice(
      BranchOffice branchOffice, String accessToken) async {
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    var body = json.encode(branchOffice.toJsonRegistry());
    Uri uri = Uri.http(Constants.urlAuthority, Constants.urlInsertBranchOffice);
    var res = await http.post(uri,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer " + accessToken
        },
        body: body);

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;
    if (apiResponse.statusResponse == 200) {
      _branchOffice = BranchOffice.fromJson(resBody);
      apiResponse.object = _branchOffice;
    } else {
      _error = ErrorApiResponse.fromJson(resBody);
      FLog.error(text: _error.toJson().toString());
      apiResponse.object = _error;
    }
    return apiResponse;
  }

  Future<ApiResponse> updateBranchOffice(
      BranchOffice user, String accessToken) async {
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    var body = json.encode(user.toJson());
    Uri uri = Uri.http(Constants.urlAuthority, Constants.urlUpdateBranchOffice);
    var res = await http.put(uri,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer " + accessToken
        },
        body: body);

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;
    if (apiResponse.statusResponse == 200) {
      _branchOffice = BranchOffice.fromJson(resBody);
      apiResponse.object = _branchOffice;
    } else {
      _error = ErrorApiResponse.fromJson(resBody);
      FLog.error(text: _error.toJson().toString());
      apiResponse.object = _error;
    }
    return apiResponse;
  }

  Future<ApiResponse> deleteBranchOffice(int id, String accessToken) async {
    ApiResponse apiResponse = ApiResponse(statusResponse: 0);
    var queryParameters = {'id': id.toString()};
    Uri uri = Uri.http(Constants.urlAuthority, Constants.urlDeletePBranchOffice,
        queryParameters);
    var res = await http.delete(uri,
        headers: {HttpHeaders.authorizationHeader: "Bearer " + accessToken});

    var resBody = json.decode(res.body);
    apiResponse.statusResponse = res.statusCode;
    if (apiResponse.statusResponse == 200) {
      _branchOffice = BranchOffice.fromJson(resBody);
      apiResponse.object = _branchOffice;
    } else {
      _error = ErrorApiResponse.fromJson(resBody);
      apiResponse.object = _error;
    }
    return apiResponse;
  }
}
