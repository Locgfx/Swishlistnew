class NotificationModel {
  int? code;
  bool? status;
  String? message;
  Data? data;

  NotificationModel({this.code, this.status, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    // data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  String? followRequest;
  String? sharedWithMe;
  String? friendAddProduct;
  String? appUpdate;
  String? createdAt;
  User? user;

  Data(
      {this.id,
        this.userId,
        this.followRequest,
        this.sharedWithMe,
        this.friendAddProduct,
        this.appUpdate,
        this.createdAt,
        this.user});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    followRequest = json['follow_request'];
    sharedWithMe = json['shared_with_me'];
    friendAddProduct = json['friend_add_product'];
    appUpdate = json['app_update'];
    createdAt = json['created_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['follow_request'] = this.followRequest;
    data['shared_with_me'] = this.sharedWithMe;
    data['friend_add_product'] = this.friendAddProduct;
    data['app_update'] = this.appUpdate;
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

