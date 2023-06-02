// class GetPetsModel {
//   GetPetsModel({
//     required this.code,
//     required this.status,
//     required this.message,
//     required this.data,
//   });
//   late final int code;
//   late final bool status;
//   late final String message;
//   late final List<Data> data;
//
//   GetPetsModel.fromJson(Map<String, dynamic> json){
//     code = json['code'];
//     status = json['status'];
//     message = json['message'];
//     data = List.from(json['data']).map((e)=> Data.fromJson(e)).toList();
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['code'] = code;
//     _data['status'] = status;
//     _data['message'] = message;
//     _data['data'] = data.map((e)=>e.toJson()).toList();
//     return _data;
//   }
// }
//
// class Data {
//   Data({
//     required this.id,
//     required this.userId,
//     required this.name,
//     required this.type,
//     required this.origin,
//     required this.photo,
//     required this.privacyStatus,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.deletedAt,
//     required this.user,
//   });
//   late final int id;
//   late final int userId;
//   late final String name;
//   late final String type;
//   late final String origin;
//   late final String photo;
//   late final String privacyStatus;
//   late final String createdAt;
//   late final String updatedAt;
//   late final String deletedAt;
//   late final User user;
//
//   Data.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     userId = json['user_id'];
//     name = json['name'];
//     type = json['type'];
//     origin = json['origin'];
//     photo = json['photo'];
//     privacyStatus = json['privacy_status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = json['deleted_at'].toString();
//     user = User.fromJson(json['user']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic> {};
//     _data['id'] = id;
//     _data['user_id'] = userId;
//     _data['name'] = name;
//     _data['type'] = type;
//     _data['origin'] = origin;
//     _data['photo'] = photo;
//     _data['privacy_status'] = privacyStatus;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     _data['deleted_at'] = deletedAt;
//     _data['user'] = user.toJson();
//     return _data;
//   }
// }
//
// class User {
//   User({
//     required this.id,
//     required this.name,
//     required this.username,
//     required this.phone,
//     required this.email,
//     required this.photo,
//     required this.type,
//   });
//   late final int id;
//   late final String name;
//   late final String username;
//   late final String phone;
//   late final String email;
//   late final String photo;
//   late final String type;
//
//   User.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     name = json['name'];
//     username = json['username'].toString();
//     phone = json['phone'].toString();
//     email = json['email'].toString();
//     photo = json['photo'].toString();
//     type = json['type'].toString();
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['name'] = name;
//     _data['username'] = username;
//     _data['phone'] = phone;
//     _data['email'] = email;
//     _data['photo'] = photo;
//     _data['type'] = type;
//     return _data;
//   }
// }
//
//


class PetsModel {
  int? code;
  bool? status;
  String? message;
  List<Data>? data;
  PetsModel({this.code, this.status, this.message, this.data});
  PetsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? name;
  String? type;
  String? origin;
  String? photo;
  String? privacyStatus;
  String? createdAt;
  User? user;

  Data(
      {this.id,
        this.userId,
        this.name,
        this.type,
        this.origin,
        this.photo,
        this.privacyStatus,
        this.createdAt,
        this.user});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    type = json['type'];
    origin = json['origin'];
    photo = json['photo'];
    privacyStatus = json['privacy_status'];
    createdAt = json['created_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['origin'] = this.origin;
    data['photo'] = this.photo;
    data['privacy_status'] = this.privacyStatus;
    data['created_at'] = this.createdAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? username;
  String? phone;
  String? email;
  String? photo;
  String? type;

  User(
      {this.id,
        this.name,
        this.username,
        this.phone,
        this.email,
        this.photo,
        this.type});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    phone = json['phone'];
    email = json['email'];
    photo = json['photo'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['photo'] = this.photo;
    data['type'] = this.type;
    return data;
  }
}