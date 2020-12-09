import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ManageToken {
  final _storage = FlutterSecureStorage();
  String accessTokenSesion = "";
  String accessEmail = "";

  Future<Map<String, String>> getAllValue() async {
    return _storage.readAll();
  }

  Future<String> getValueByKey(String key) async {
    return _storage.read(key: key);
  }

  Future<String> getValueToken() async {
    await getToken();
    return _storage.read(key: 'token');
  }

  Future<String> getValueEmail() async {
    await getToken();
    return _storage.read(key: 'email');
  }

  Future deleteValue(String key) async {
    await _storage.delete(key: key);
  }

  Future deleteAllValue() async {
    await _storage.deleteAll();
  }

  Future writeValue(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future getToken() async {
    accessTokenSesion = await getValueByKey('token');
  }

  Future getEmail() async {
    accessEmail = await getValueByKey('email');
  }

  Future get tokenSesion async {
    accessTokenSesion = await _storage.read(key: 'token');
  }

  void saveToken(String token) async {
    await writeValue('token', token);
    accessTokenSesion = await _storage.read(key: 'token');
  }

  void saveEmail(String email) async {
    await writeValue('email', email);
    accessEmail = await _storage.read(key: 'email');
  }

  bool existToken() {
    var token;
    _storage.read(key: 'token').then((value) => token = value);

    return token != null;
  }

  void logout() async {
    await deleteValue('token');
  }

  Future get accessToken => getToken();
  Future get email => getEmail();
}
