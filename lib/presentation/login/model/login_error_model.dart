import 'dart:convert';

LoginErrorResponse loginErrorResponseFromJson(String str) =>
    LoginErrorResponse.fromJson(json.decode(str));

String loginErrorResponseToJson(LoginErrorResponse data) =>
    json.encode(data.toJson());

class LoginErrorResponse {
  LoginErrorResponse({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.data,
  });

  String statusCode;
  String status;
  String message;
  Data data;

  factory LoginErrorResponse.fromJson(Map<String, dynamic> json) =>
      LoginErrorResponse(
        statusCode: json["status_code"],
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
