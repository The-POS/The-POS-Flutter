class forbidenOperation {
  String code;
  String message;

  forbidenOperation({
    required this.code,
    required this.message,
  });

  factory forbidenOperation.fromJson(Map<String, dynamic> json) => forbidenOperation(
    code: json['code'],
    message: json["message"],
  );
}
