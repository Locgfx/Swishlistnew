// class SearchModel {
//   int? code;
//   bool? status;
//   String? message;
//   List<Data>? data;
//
//   SearchModel({this.code, this.status, this.message, this.data});
//
//   SearchModel.fromJson(Map<String, dynamic> json) {
//     code = json['code'];
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['code'] = this.code;
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   int? userId;
//   String? name;
//   String? gender;
//   String? dob;
//   String? occupation;
//   String? relationStatus;
//   String? email;
//   String? phone;
//   String? alternatePhone;
//   String? homeAddress;
//   String? workAddress;
//   String? privacyStatus;
//   String? createdAt;
//   String? updatedAt;
//   String? deletedAt;
//   User? user;
//
//   Data(
//       {this.id,
//         this.userId,
//         this.name,
//         this.gender,
//         this.dob,
//         this.occupation,
//         this.relationStatus,
//         this.email,
//         this.phone,
//         this.alternatePhone,
//         this.homeAddress,
//         this.workAddress,
//         this.privacyStatus,
//         this.createdAt,
//         this.updatedAt,
//         this.deletedAt,
//         this.user});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     name = json['name'];
//     gender = json['gender'].toString();
//     dob = json['dob'];
//     occupation = json['occupation'];
//     relationStatus = json['relation_status'];
//     email = json['email'];
//     phone = json['phone'];
//     alternatePhone = json['alternate_phone'];
//     homeAddress = json['home_address'];
//     workAddress = json['work_address'];
//     privacyStatus = json['privacy_status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = json['deleted_at'].toString();
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['name'] = this.name;
//     data['gender'] = this.gender;
//     data['dob'] = this.dob;
//     data['occupation'] = this.occupation;
//     data['relation_status'] = this.relationStatus;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['alternate_phone'] = this.alternatePhone;
//     data['home_address'] = this.homeAddress;
//     data['work_address'] = this.workAddress;
//     data['privacy_status'] = this.privacyStatus;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['deleted_at'] = this.deletedAt;
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     return data;
//   }
// }
//
// class User {
//   int? id;
//   String? name;
//   String? username;
//   String? phone;
//   String? email;
//   String? photo;
//   String? type;
//
//   User(
//       {this.id,
//         this.name,
//         this.username,
//         this.phone,
//         this.email,
//         this.photo,
//         this.type});
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     username = json['username'];
//     phone = json['phone'];
//     email = json['email'];
//     photo = json['photo'];
//     type = json['type'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['username'] = this.username;
//     data['phone'] = this.phone;
//     data['email'] = this.email;
//     data['photo'] = this.photo;
//     data['type'] = this.type;
//     return data;
//   }
// }


class SearchModel {
  int? id;
  int? userId;
  String? name;
  String? gender;
  String? dob;
  String? occupation;
  String? relationStatus;
  String? email;
  String? phone;
  String? alternatePhone;
  String? homeAddress;
  String? workAddress;
  String? privacyStatus;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  SearchModel(
      {this.id,
        this.userId,
        this.name,
        this.gender,
        this.dob,
        this.occupation,
        this.relationStatus,
        this.email,
        this.phone,
        this.alternatePhone,
        this.homeAddress,
        this.workAddress,
        this.privacyStatus,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        });

  SearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    gender = json['gender'].toString();
    dob = json['dob'];
    occupation = json['occupation'];
    relationStatus = json['relation_status'];
    email = json['email'];
    phone = json['phone'];
    alternatePhone = json['alternate_phone'];
    homeAddress = json['home_address'];
    workAddress = json['work_address'];
    privacyStatus = json['privacy_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'].toString();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['occupation'] = this.occupation;
    data['relation_status'] = this.relationStatus;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['alternate_phone'] = this.alternatePhone;
    data['home_address'] = this.homeAddress;
    data['work_address'] = this.workAddress;
    data['privacy_status'] = this.privacyStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}