/*
class ProductTypeModel {
  int? id;
  int? userId;
  String? type;
  String? name;
  String? link;
  String? price;
  String? photo;
  String? purchasedDate;
  String? privacyStatus;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  User? user;

  ProductTypeModel(
      {this.id,
        this.userId,
        this.type,
        this.name,
        this.link,
        this.price,
        this.photo,
        this.purchasedDate,
        this.privacyStatus,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.user});

  ProductTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    type = json['type'];
    name = json['name'];
    link = json['link'];
    price = json['price'];
    photo = json['photo'];
    purchasedDate = json['purchased_date'];
    privacyStatus = json['privacy_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'].toString();
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['name'] = this.name;
    data['link'] = this.link;
    data['price'] = this.price;
    data['photo'] = this.photo;
    data['purchased_date'] = this.purchasedDate;
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
}*/

/*

class ProductTypeModel {
  int? id;
  int? userId;
  String? type;
  String? name;
  String? link;
  String? price;
  String? photo;
  String? purchasedDate;
  String? privacyStatus;
  String? createdAt;
  User? user;

  ProductTypeModel(
      {this.id,
        this.userId,
        this.type,
        this.name,
        this.link,
        this.price,
        this.photo,
        this.purchasedDate,
        this.privacyStatus,
        this.createdAt,
        this.user});

  ProductTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    type = json['type'];
    name = json['name'];
    link = json['link'];
    price = json['price'];
    photo = json['photo'];
    purchasedDate = json['purchased_date'];
    privacyStatus = json['privacy_status'];
    createdAt = json['created_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['name'] = this.name;
    data['link'] = this.link;
    data['price'] = this.price;
    data['photo'] = this.photo;
    data['purchased_date'] = this.purchasedDate;
    data['privacy_status'] = this.privacyStatus;
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
*/


class ProductTypeModel {
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

  ProductTypeModel(
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

  ProductTypeModel.fromJson(Map<String, dynamic> json) {
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