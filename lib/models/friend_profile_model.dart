class FriendProfileModel {
  bool? error;
  String? message;
  Data? data;

  FriendProfileModel({this.error, this.message, this.data});

  FriendProfileModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? token;
  String? fcmToken;
  String? status;
  Profile? profile;

  Data(
      {this.id,
        this.name,
        this.email,
        this.token,
        this.fcmToken,
        this.status,
        this.profile});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    token = json['token'];
    fcmToken = json['fcm_token'];
    status = json['status'];
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['token'] = this.token;
    data['fcm_token'] = this.fcmToken;
    data['status'] = this.status;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    return data;
  }
}

class Profile {
  String? username;
  String? gender;
  String? marritalStatus;
  String? dateOfBirth;
  String? occupation;
  String? phone;
  String? additionalPhone;
  String? privacy;
  String? photo;

  Profile(
      {this.username,
        this.gender,
        this.marritalStatus,
        this.dateOfBirth,
        this.occupation,
        this.phone,
        this.additionalPhone,
        this.privacy,
        this.photo});

  Profile.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    gender = json['gender'];
    marritalStatus = json['marrital_status'];
    dateOfBirth = json['date_of_birth'];
    occupation = json['occupation'];
    phone = json['phone'];
    additionalPhone = json['additional_phone'];
    privacy = json['privacy'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['gender'] = this.gender;
    data['marrital_status'] = this.marritalStatus;
    data['date_of_birth'] = this.dateOfBirth;
    data['occupation'] = this.occupation;
    data['phone'] = this.phone;
    data['additional_phone'] = this.additionalPhone;
    data['privacy'] = this.privacy;
    data['photo'] = this.photo;
    return data;
  }
}
