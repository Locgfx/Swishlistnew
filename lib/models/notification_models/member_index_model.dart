/*
class MemberIndexModel {
  int? code;
  bool? status;
  String? message;
  List<Index>? data;

  MemberIndexModel({this.code, this.status, this.message, this.data});

  MemberIndexModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Index>[];
      json['data'].forEach((v) {
        data!.add(new Index.fromJson(v));
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

class Index {
  int? id;
  int? userId;
  int? familyMemberUserId;
  String? relation;
  String? status;
  String? privacyStatus;
  String? createdAt;
  User? user;
  User? familyMemberUser;

  Index(
      {this.id,
      this.userId,
      this.familyMemberUserId,
      this.relation,
      this.status,
      this.privacyStatus,
      this.createdAt,
      this.user,
      this.familyMemberUser});

  Index.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    familyMemberUserId = json['family_member_user_id'];
    relation = json['relation'];
    status = json['status'];
    privacyStatus = json['privacy_status'];
    createdAt = json['created_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    familyMemberUser = json['family_member_user'] != null
        ? new User.fromJson(json['family_member_user'])
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
*/


class FamilyMemberIndexModel {
  int? id;
  Member? member;
  String? memberSince;

  FamilyMemberIndexModel({this.id, this.member, this.memberSince});

  FamilyMemberIndexModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    member =
    json['member'] != null ? new Member.fromJson(json['member']) : null;
    memberSince = json['member_since'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.member != null) {
      data['member'] = this.member!.toJson();
    }
    data['member_since'] = this.memberSince;
    return data;
  }
}

class Member {
  int? id;
  String? name;
  String? username;
  String? email;
  String? phone;
  String? photo;
 // String? deviceToken;
  String? fcmToken;
  String? status;
  String? complete;

  Member(
      {this.id,
        this.name,
        this.username,
        this.email,
        this.phone,
        this.photo,
        //this.deviceToken,
        this.fcmToken,
        this.status,
        this.complete});

  Member.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    photo = json['photo'];
    //deviceToken = json['device_token'];
    fcmToken = json['fcm_token'];
    status = json['status'];
    complete = json['complete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['photo'] = this.photo;
    //data['device_token'] = this.deviceToken;
    data['fcm_token'] = this.fcmToken;
    data['status'] = this.status;
    data['complete'] = this.complete;
    return data;
  }
}