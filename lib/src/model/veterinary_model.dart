import 'package:demo/src/model/user_model.dart';

class Veterinary {
  int id;
  String name;
  String nit;
  String email;
  bool state;
  //User user;
  Veterinary({
    this.id,
    this.name,
    this.nit,
    this.email,
    this.state,
    //this.user,
  });

  factory Veterinary.fromJson(Map<String, dynamic> json) {
    return new Veterinary(
      id: json['idVet'],
      name: json['nameVet'],
      nit: json['nitVet'],
      email: json['emailVet'],
      state: json['stateVet'],
    );
  }
  Map<String, dynamic> toJson() => {
        'idVet': id,
        'nameVet': name,
        'nitVet': nit,
        'emailVet': email,
        'stateVet': state,
      };
  Map<String, dynamic> toJsonRegistry() => {
        'nameVet': name,
        'nitVet': nit,
        'emailVet': email,
        'stateVet': state,
      };
}
