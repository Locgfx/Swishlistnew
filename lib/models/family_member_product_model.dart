class FamilyMemberProductModel {
  int? id;
  String? type;
  String? name;
  String? url;
  String? price;
  String? description;
  String? photo;
  String? purchasedOn;
  String? privacy;
  String? lastUpdated;
  User? user;

  FamilyMemberProductModel(
      {this.id,
        this.type,
        this.name,
        this.url,
        this.price,
        this.description,
        this.photo,
        this.purchasedOn,
        this.privacy,
        this.lastUpdated,
        this.user});

  FamilyMemberProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    url = json['url'];
    price = json['price'];
    description = json['description'];
    photo = json['photo'];
    purchasedOn = json['purchased_on'];
    privacy = json['privacy'];
    lastUpdated = json['last_updated'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    data['url'] = this.url;
    data['price'] = this.price;
    data['description'] = this.description;
    data['photo'] = this.photo;
    data['purchased_on'] = this.purchasedOn;
    data['privacy'] = this.privacy;
    data['last_updated'] = this.lastUpdated;
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
  String? email;
  String? phone;
  String? photo;
  Null? deviceToken;
  String? fcmToken;
  String? status;
  String? complete;

  User(
      {this.id,
        this.name,
        this.username,
        this.email,
        this.phone,
        this.photo,
        this.deviceToken,
        this.fcmToken,
        this.status,
        this.complete});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    photo = json['photo'];
    deviceToken = json['device_token'];
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
    data['device_token'] = this.deviceToken;
    data['fcm_token'] = this.fcmToken;
    data['status'] = this.status;
    data['complete'] = this.complete;
    return data;
  }
}