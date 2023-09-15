class FamilyMemberModel {
  int? code;
  bool? status;
  String? message;
  Data? data;

  FamilyMemberModel({this.code, this.status, this.message, this.data});

  FamilyMemberModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? userId;
  String? familyMemberUserId;
  String? relation;
  String? status;
  String? privacyStatus;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.userId,
        this.familyMemberUserId,
        this.relation,
        this.status,
        this.privacyStatus,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    familyMemberUserId = json['family_member_user_id'];
    relation = json['relation'];
    status = json['status'];
    privacyStatus = json['privacy_status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['family_member_user_id'] = this.familyMemberUserId;
    data['relation'] = this.relation;
    data['status'] = this.status;
    data['privacy_status'] = this.privacyStatus;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}