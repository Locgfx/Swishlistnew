class FriendSizingModel {
  bool? error;
  String? message;
  Data? data;

  FriendSizingModel({this.error, this.message, this.data});

  FriendSizingModel.fromJson(Map<String, dynamic> json) {
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
  Sizing? sizing;

  Data(
      {this.id,
        this.name,
        this.email,
        this.token,
        this.fcmToken,
        this.status,
        this.sizing});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    token = json['token'];
    fcmToken = json['fcm_token'];
    status = json['status'];
    sizing =
    json['sizing'] != null ? new Sizing.fromJson(json['sizing']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['token'] = this.token;
    data['fcm_token'] = this.fcmToken;
    data['status'] = this.status;
    if (this.sizing != null) {
      data['sizing'] = this.sizing!.toJson();
    }
    return data;
  }
}

class Sizing {
  int? id;
  String? waist;
  String? shirt;
  String? shoe;
  String? bed;
  String? privacy;
  String? complete;

  Sizing(
      {this.id,
        this.waist,
        this.shirt,
        this.shoe,
        this.bed,
        this.privacy,
        this.complete});

  Sizing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    waist = json['waist'];
    shirt = json['shirt'];
    shoe = json['shoe'];
    bed = json['bed'];
    privacy = json['privacy'];
    complete = json['complete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['waist'] = this.waist;
    data['shirt'] = this.shirt;
    data['shoe'] = this.shoe;
    data['bed'] = this.bed;
    data['privacy'] = this.privacy;
    data['complete'] = this.complete;
    return data;
  }
}
