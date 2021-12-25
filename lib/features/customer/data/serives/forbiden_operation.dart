class ForbiddenOperation {
  String code;
  String message;

  ForbiddenOperation({
    required this.code,
    required this.message,
  });

  factory ForbiddenOperation.fromJson(Map<String, dynamic> json) => ForbiddenOperation(
    code: json['code'],
    message: json["message"],
  );
}
