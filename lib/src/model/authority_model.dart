class Authority {
  String authority;

  Authority({this.authority});

  factory Authority.fromJson(Map<String, dynamic> json) {
    return Authority(
      authority: json['authority'],
    );
  }

  Map<String, dynamic> toJson() => {
        'authority': authority,
      };
}
