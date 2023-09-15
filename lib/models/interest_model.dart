

class InterestModel {
  int? code;
  bool? status;
  String? message;
  Data? data;

  InterestModel({this.code, this.status, this.message, this.data});

  InterestModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if(json['data'].runtimeType == List<dynamic> ) {
      print('v');
      data = Data.fromJson({});
    } else if(json['data'] == null){
      print('kkk');
      data = Data.fromJson({});
    } else{
      print('mdkmc');
      data = Data.fromJson(json['data']);
    }
    // data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    // data = json['data'] == [] ? null : json['data'] != null   ? Data.fromJson(json['data']) : null;
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
  int? id;
  int? userId;
  String? interest;
  String? privacyStatus;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  User? user;

  Data(
      {this.id,
        this.userId,
        this.interest,
        this.privacyStatus,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.user});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    interest = json['interest'];
    privacyStatus = json['privacy_status'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'].toString();
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['interest'] = this.interest;
    data['privacy_status'] = this.privacyStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
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


