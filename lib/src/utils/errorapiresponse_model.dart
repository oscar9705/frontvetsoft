class ErrorApiResponse {
  int status;
  String message;
  Object object;
  ErrorApiResponse({this.status, this.object, this.message});

  factory ErrorApiResponse.fromJson(Map<String, dynamic> json) {
    return ErrorApiResponse(
        status: json['statusResponse'], object: json['object']);
  }

  Map<String, dynamic> toJson() => {'statusReponse': status, 'object': object};
}
