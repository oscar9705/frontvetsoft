import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ManageToken {
  final _storage = FlutterSecureStorage();
  String accessToken;

  Future<Map<String, String>> getAllValue() async {
    return _storage.readAll();
  }

  Future<String> getValueByKey(String key) async {
    return _storage.read(key: key);
  }

  Future<bool> existValueByKey() async {
    if (_storage.read(key: 'token') != '') {
      return true;
    } else {
      return false;
    }
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
    accessToken = await getValueByKey('token');
  }

  Future get tokenSesion async {
    accessToken = await _storage.read(key: 'token');
  }

  void saveToken(String token) async {
    await writeValue('token', token);
    accessToken = await _storage.read(key: 'token');
  }

  bool existToken() {
    var token;
    _storage.read(key: 'token').then((value) => token = value);
    print(token);
    return token != null;
  }

  void logout() async {
    await deleteValue('token');
  }

  Future get accessTokenSesion => getToken();
}
