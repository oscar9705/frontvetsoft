class Token {
  String token;
  String bearer;
  String username;

  Token({this.token, this.bearer, this.username});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      token: json['token'],
      bearer: json['bearer'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() => {
        'token': token,
        'bearer': bearer,
        'username': username,
      };
}
