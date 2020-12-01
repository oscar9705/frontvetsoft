class User {
  int id;
  String names;
  String surnames;
  String documentType;
  String documentValue;
  DateTime birthdate;
  String department;
  String city;
  String neighborhood;
  String telephone;
  String email;
  String password;
  bool state;
  String role;

  User(
      {this.id,
      this.names,
      this.surnames,
      this.documentType,
      this.documentValue,
      this.birthdate,
      this.department,
      this.city,
      this.neighborhood,
      this.telephone,
      this.email,
      this.password,
      this.state,
      this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        names: json['names'],
        surnames: json['surnames'],
        documentType: json['documentType'],
        documentValue: json['documentValue'],
        birthdate: json['birthdate'],
        department: json['department'],
        city: json['city'],
        neighborhood: json['neighborhood'],
        telephone: json['telephone'],
        email: json['email'],
        password: json['password'],
        state: json['state'],
        role: json['roleUser']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'names': names,
        'surnames': surnames,
        'documentType': documentType,
        'documentValue': documentValue,
        'birthdate': birthdate,
        'department': department,
        'city': city,
        'neighborhood': neighborhood,
        'telephone': telephone,
        'email': email,
        'password': password,
        'state': state,
        'roleUser': role
      };

  Map<String, dynamic> toJsonRegistry() => {
        'names': names,
        'surnames': surnames,
        'documentType': documentType,
        'documentValue': documentValue,
        'birthdate': birthdate,
        'department': department,
        'city': city,
        'neighborhood': neighborhood,
        'telephone': telephone,
        'email': email,
        'password': password,
        'state': state,
        'roleUser': role
      };
}
