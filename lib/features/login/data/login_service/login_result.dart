class LoginResult {
  LoginResult({
    required this.token,
    required this.user,
    required this.expire,
    required this.displayName,
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) => LoginResult(
        token: json['token'],
        user: json['user'],
        expire: json['expire'],
        displayName: json['display_name'],
      );

  String token;
  String user;
  int expire;
  String displayName;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['user'] = user;
    data['expire'] = expire;
    data['display_name'] = displayName;
    return data;
  }
}
