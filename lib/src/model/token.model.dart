class Token {
  String token;
  String bearer;
  String username;
  Map<String, String> authorities;

  Token({
    this.token,
    this.bearer,
    this.username,
    this.authorities,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
        token: json['token'],
        bearer: json['bearer'],
        username: json['username'],
        authorities: json['authorities']);
  }

  Map<String, dynamic> toJson() => {
        'token': token,
        'bearer': bearer,
        'username': username,
        'authorities': authorities
      };
}
