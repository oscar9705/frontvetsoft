class Appointment {
  String id;
  String hour;
  String date;

  Appointment({this.id, this.hour, this.date});

  factory Appointment.fromJson(Map<String, dynamic> parsedJson) {
    return Appointment(
        id: parsedJson['id'],
        hour: parsedJson['hour'],
        date: parsedJson['date']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'hour': hour, 'date': date};

  Map<String, dynamic> toJsonRegistry() =>
      {'id': id, 'hour': hour, 'date': date};
}
