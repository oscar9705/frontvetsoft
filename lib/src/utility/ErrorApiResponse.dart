class ErrorApiResponse {
  int statusResponse;
  String message;
  Object object;
  ErrorApiResponse({this.statusResponse, this.message, this.object});

  factory ErrorApiResponse.fromJson(Map<String, dynamic> json) {
    return ErrorApiResponse(
        statusResponse: json['statusCode'], object: json['object']);
  }

  Map<String, dynamic> toJson() =>
      {'statusResponse': statusResponse, 'object': object};
}
