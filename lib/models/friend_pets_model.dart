class FriendPetModel {
  bool? error;
  String? message;
  Data? data;

  FriendPetModel({this.error, this.message, this.data});

  FriendPetModel.fromJson(Map<String, dynamic> json) {
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
  List<Pets>? pets;

  Data(
      {this.id,
        this.name,
        this.email,
        this.token,
        this.fcmToken,
        this.status,
        this.pets});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    token = json['token'];
    fcmToken = json['fcm_token'];
    status = json['status'];
    if (json['pets'] != null) {
      pets = <Pets>[];
      json['pets'].forEach((v) {
        pets!.add(new Pets.fromJson(v));
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
    if (this.pets != null) {
      data['pets'] = this.pets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pets {
  int? id;
  String? name;
  String? type;
  String? origin;
  String? photo;
  String? privacy;
  String? createdAt;
  String? updatedAt;
  String? complete;

  Pets(
      {this.id,
        this.name,
        this.type,
        this.origin,
        this.photo,
        this.privacy,
        this.createdAt,
        this.updatedAt,
        this.complete});

  Pets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    origin = json['origin'];
    photo = json['photo'];
    privacy = json['privacy'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    complete = json['complete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['origin'] = this.origin;
    data['photo'] = this.photo;
    data['privacy'] = this.privacy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['complete'] = this.complete;
    return data;
  }
}
