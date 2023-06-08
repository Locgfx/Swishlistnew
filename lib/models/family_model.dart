
class GetFamilyModel {
  int? code;
  bool? status;
  String? message;
  List<Data>? data;

  GetFamilyModel({this.code, this.status, this.message, this.data});

  GetFamilyModel.fromJson(Map<String, dynamic> json) {
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
  int? familyMemberUserId;
  String? relation;
  String? status;
  String? privacyStatus;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  User? user;
  FamilyMemberUser? familyMemberUser;

  Data(
      {this.id,
        this.userId,
        this.familyMemberUserId,
        this.relation,
        this.status,
        this.privacyStatus,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.user,
        this.familyMemberUser});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    familyMemberUserId = json['family_member_user_id'];
    relation = json['relation'];
    status = json['status'];
    privacyStatus = json['privacy_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'].toString();
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    familyMemberUser = json['family_member_user'] != null
        ? new FamilyMemberUser.fromJson(json['family_member_user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['family_member_user_id'] = this.familyMemberUserId;
    data['relation'] = this.relation;
    data['status'] = this.status;
    data['privacy_status'] = this.privacyStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.familyMemberUser != null) {
      data['family_member_user'] = this.familyMemberUser!.toJson();
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

class FamilyMemberUser {
  int? id;
  String? name;
  String? username;
  String? phone;
  String? email;
  String? photo;
  String? type;

  FamilyMemberUser(
      {this.id,
        this.name,
        this.username,
        this.phone,
        this.email,
        this.photo,
        this.type});

  FamilyMemberUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'].toString();
    username = json['username'].toString();
    phone = json['phone'].toString();
    email = json['email'];
    photo = json['photo'].toString();
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
