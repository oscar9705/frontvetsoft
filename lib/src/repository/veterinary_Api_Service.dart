import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../model/veterinary_model.dart';

class VeterinaryApiService {
  Veterinary _veterinary;

  VeterinaryApiService();

  String urlAutorithy = "";
  String method = "";
  Future<Veterinary> saveVeterinary(Veterinary veterinary) async {
    var body = json.encode(veterinary.toJsonRegistry());
    Uri url = Uri.http(urlAutorithy, method);
    var res = await http.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
      body: body,
    );
    var resBody = json.decode(res.body);
    _veterinary = Veterinary.fromJson(resBody);
    return _veterinary;
  }

  Future<Veterinary> updateVeterinary(Veterinary veterinary) async {
    var body = json.encode(veterinary.toJson());
    Uri url = Uri.http(urlAutorithy, method);
    var res = await http.put(
      url,
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
      body: body,
    );
    var resBody = json.decode(res.body);
    _veterinary = Veterinary.fromJson(resBody);
    return _veterinary;
  }

  Future<List<Veterinary>> findAllVeterinary() async {
    List<Veterinary> listVeterinary = List();
    Uri url = Uri.http(urlAutorithy, method);
    var resp = await http.get(url);
    var respBody = json.decode(resp.body);

    respBody.forEach((i) {
      listVeterinary.add(Veterinary.fromJson(i));
    });
    return listVeterinary;
  }
}
