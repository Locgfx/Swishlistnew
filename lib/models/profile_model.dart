class ProfileModel {
  int? code;
  bool? status;
  String? message;
  ProfileData? data;

  ProfileModel({this.code, this.status, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['data'].runtimeType == List<dynamic>) {
      print('v');
      // data = Data.fromJson({
      //
      // });
      data = ProfileData(
          name: '',
          gender: '',
          dob: '',
          occupation: '',
          relationStatus: '',
          email: '',
          phone: '',
          alternatePhone: '',
          homeAddress: '',
          workAddress: '',
          privacyStatus: '',
          createdAt: '',
          updatedAt: '',
          deletedAt: '',
          user: ProfileUser(
            name: '',
            username: '',
            phone: '',
            email: '',
            photo: '',
            type: '',
          ));
    } else if (json['data'] == null) {
      print('kkk');
      data = ProfileData.fromJson({});
    } else {
      print('mdkmc');
      data = ProfileData.fromJson(json['data']);
    }
    // data = json ['data'] == [] ? null :json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class ProfileData {
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
  String? completePercent;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  ProfileUser? user;

  ProfileData(
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
      this.completePercent,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.user});

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    gender = json['gender'];
    dob = json['dob'];
    occupation = json['occupation'];
    relationStatus = json['relation_status'];
    email = json['email'];
    phone = json['phone'];
    alternatePhone = json['alternate_phone'];
    homeAddress = json['home_address'];
    workAddress = json['work_address'];
    privacyStatus = json['privacy_status'];
    completePercent = json['complete_percent'];
    deletedAt = json['deleted_at'];
    user = json['user'] != null ? new ProfileUser.fromJson(json['user']) : null;
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
    data['complete_percent'] = this.completePercent;
    data['created_at'] = this.createdAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class ProfileUser {
  int? id;
  String? name;
  String? username;
  String? phone;
  String? email;
  String? photo;
  String? type;

  ProfileUser(
      {this.id,
      this.name,
      this.username,
      this.phone,
      this.email,
      this.photo,
      this.type});

  ProfileUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'].toString();
    phone = json['phone'].toString();
    email = json['email'].toString();
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

//
// class ProfileModel {
//   int? code;
//   bool? status;
//   String? message;
//   Data? data;
//
//   ProfileModel({this.code, this.status, this.message, this.data});
//
//   ProfileModel.fromJson(Map<String, dynamic> json) {
//     code = json['code'];
//     status = json['status'];
//     message = json['message'];
//
//     if(json['data'].runtimeType == List<dynamic> ) {
//       print('v');
//       // data = Data.fromJson({
//       //
//       // });
//       data = Data(
//         name: '',
//         gender: '',
//         dob: '',
//         occupation: '',
//         relationStatus: '',
//         email: '',
//         phone: '',
//         alternatePhone: '',
//         homeAddress: '',
//         workAddress:'',
//         privacyStatus: '',
//         createdAt: '',
//         user: User(
//           name: '',
//           username: '',
//           phone: '',
//           email: '',
//           photo: '',
//           type: '',
//         )
//       );
//     } else if(json['data'] == null) {
//       print('kkk');
//       data = Data.fromJson({});
//     } else{
//       print('mdkmc');
//       data = Data.fromJson(json['data']);
//     }
//     // data = json ['data'] == [] ? null :json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['code'] = this.code;
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   int? userId;
//   String? name;
//   String? photo;
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
//   String? completePercent;
//   String? createdAt;
//   User? user;
//
//   Data(
//       {this.id,
//         this.userId,
//         this.name,
//         this.photo,
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
//         this.completePercent,
//         this.createdAt,
//         this.user});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     name = json['name'];
//     photo = json['photo'];
//     gender = json['gender'];
//     dob = json['dob'];
//     occupation = json['occupation'];
//     relationStatus = json['relation_status'];
//     email = json['email'];
//     phone = json['phone'];
//     alternatePhone = json['alternate_phone'];
//     homeAddress = json['home_address'];
//     workAddress = json['work_address'];
//     privacyStatus = json['privacy_status'];
//     completePercent = json['complete_percent'];
//     createdAt = json['created_at'];
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['name'] = this.name;
//     data['photo'] = this.photo;
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
//     data['complete_percent'] = this.completePercent;
//     data['created_at'] = this.createdAt;
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
