class LoginResponse {
  LoginResponse({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
    required this.token,
  });
  late final int code;
  late final bool status;
  late final String message;
  late final UserLogin data;
  late final String token;

  LoginResponse.fromJson(Map<String, dynamic> json){
    code = json['code'];
    status = json['status'];
    message = json['message'];
    data = UserLogin.fromJson(json['data']);
    token = json['token'].toString();
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

class UserLogin {
  UserLogin({
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

  UserLogin.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'].toString();
    username = json['username'].toString();
    email = json['email'];
    phone = json['phone'].toString();
    photo = json['photo'].toString();
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

