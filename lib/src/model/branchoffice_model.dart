class BranchOffice {
  int id;
  String address;
  String telephone;
  String image;

  BranchOffice({this.id, this.address, this.telephone, this.image});

  factory BranchOffice.fromJson(Map<String, dynamic> json) {
    return BranchOffice(
      id: json['id'],
      address: json['address'],
      telephone: json['telephone'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'address': address,
        'telephone': telephone,
        'image': image,
      };

  Map<String, dynamic> toJsonRegistry() => {
        'address': address,
        'telephone': telephone,
        'image': image,
      };
}
