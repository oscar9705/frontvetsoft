class Pet {
  int idPet;
  String namePet;
  String speciePet;
  String agePet;
  String breedPet;
  String sexPet;
  String observation;
  int ownerPet;
  bool statePet;

  Pet(
      {this.idPet,
      this.namePet,
      this.speciePet,
      this.agePet,
      this.breedPet,
      this.sexPet,
      this.observation,
      this.ownerPet,
      this.statePet});

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
        idPet: json['idPet'],
        namePet: json['namePet'],
        speciePet: json['speciePet'],
        agePet: json['agePet'],
        breedPet: json['breedPet'],
        sexPet: json['sexPet'],
        observation: json['observation'],
        ownerPet: json['ownerPet'],
        statePet: json['statePet']);
  }

  Map<String, dynamic> toJson() => {
        'idPet': idPet,
        'namePet': namePet,
        'speciePet': speciePet,
        'agePet': agePet,
        'breedPet': breedPet,
        'sexPet': sexPet,
        'observation': observation,
        'ownerPet': ownerPet,
        'statePet': statePet
      };

  Map<String, dynamic> toJsonRegistry() => {
        'namePet': namePet,
        'speciePet': speciePet,
        'agePet': agePet,
        'breedPet': breedPet,
        'sexPet': sexPet,
        'observation': observation,
        'ownerPet': ownerPet,
        'statePet': statePet
      };
}
