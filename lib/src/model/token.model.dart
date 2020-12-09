import 'package:demo/src/model/authority_model.dart';

class Token {
  String token;
  String bearer;
  String username;
  List<Authority> role;

  Token({this.token, this.bearer, this.username, this.role});
  factory Token.fromJson(Map<String, dynamic> json) {
    var list = json['authorities'] as List;
    List<Authority> authorityList =
        list.map((e) => Authority.fromJson(e)).toList();
    return Token(
      token: json['token'],
      bearer: json['bearer'],
      username: json['username'],
      role: authorityList,
    );
  }

  Map<String, dynamic> toJson() => {
        'token': token,
        'bearer': bearer,
        'username': username,
        'role': role,
      };
}
