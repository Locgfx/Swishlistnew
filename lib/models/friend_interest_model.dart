class FriendInterestModel {
  bool? error;
  String? message;
  Data? data;

  FriendInterestModel({this.error, this.message, this.data});

  FriendInterestModel.fromJson(Map<String, dynamic> json) {
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
  Null? token;
  String? fcmToken;
  String? status;
  List<Interests>? interests;

  Data(
      {this.id,
        this.name,
        this.email,
        this.token,
        this.fcmToken,
        this.status,
        this.interests});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    token = json['token'];
    fcmToken = json['fcm_token'];
    status = json['status'];
    if (json['interests'] != null) {
      interests = <Interests>[];
      json['interests'].forEach((v) {
        interests!.add(new Interests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['token'] = this.token;
    data['fcm_token'] = this.fcmToken;
    data['status'] = this.status;
    if (this.interests != null) {
      data['interests'] = this.interests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Interests {
  int? id;
  List<String>? interests;
  String? privacy;

  Interests({this.id, this.interests, this.privacy});

  Interests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    interests = json['interests'].cast<String>();
    privacy = json['privacy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['interests'] = this.interests;
    data['privacy'] = this.privacy;
    return data;
  }
}
