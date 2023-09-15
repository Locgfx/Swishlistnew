class VerifyResponse {
  VerifyResponse({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
    required this.token,
  });
  late final int code;
  late final String status;
  late final String message;
  late final User data;
  late final String token;

  VerifyResponse.fromJson(Map<String, dynamic> json){
    code = json['code'];
    status = json['status'].toString();
    message = json['message'];
    data = User.fromJson(json['data']);
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data.toJson();
    _data['token'] = token;
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.photo,
  });
  late final int id;
  late final String name;
  late final String username;
  late final String email;
  late final String phone;
  late final String photo;

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['username'] = username;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['photo'] = photo;
    return _data;
  }
}