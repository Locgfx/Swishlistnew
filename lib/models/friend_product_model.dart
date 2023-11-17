// class FriendProductModel {
//   int? code;
//   bool? status;
//   String? message;
//   Data? data;
//
//   FriendProductModel({this.code, this.status, this.message, this.data});
//
//   FriendProductModel.fromJson(Map<String, dynamic> json) {
//     code = json['code'];
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
//   List<Want>? want;
//   List<Have>? have;
//   List<DontWant>? dontWant;
//
//   Data({this.want, this.have, this.dontWant});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['want'] != null) {
//       want = <Want>[];
//       json['want'].forEach((v) {
//         want!.add(new Want.fromJson(v));
//       });
//     }
//     if (json['have'] != null) {
//       have = <Have>[];
//       json['have'].forEach((v) {
//         have!.add(new Have.fromJson(v));
//       });
//     }
//     if (json['dont_want'] != null) {
//       dontWant = <DontWant>[];
//       json['dont_want'].forEach((v) {
//         dontWant!.add(new DontWant.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.want != null) {
//       data['want'] = this.want!.map((v) => v.toJson()).toList();
//     }
//     if (this.have != null) {
//       data['have'] = this.have!.map((v) => v.toJson()).toList();
//     }
//     if (this.dontWant != null) {
//       data['dont_want'] = this.dontWant!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Want {
//   int? id;
//   int? userId;
//   String? type;
//   String? name;
//   String? link;
//   String? price;
//   String? photo;
//   String? purchasedDate;
//   String? privacyStatus;
//   String? createdAt;
//
//   Want(
//       {this.id,
//       this.userId,
//       this.type,
//       this.name,
//       this.link,
//       this.price,
//       this.photo,
//       this.purchasedDate,
//       this.privacyStatus,
//       this.createdAt});
//
//   Want.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     type = json['type'];
//     name = json['name'];
//     link = json['link'];
//     price = json['price'];
//     photo = json['photo'];
//     purchasedDate = json['purchased_date'];
//     privacyStatus = json['privacy_status'];
//     createdAt = json['created_at'];
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['type'] = this.type;
//     data['name'] = this.name;
//     data['link'] = this.link;
//     data['price'] = this.price;
//     data['photo'] = this.photo;
//     data['purchased_date'] = this.purchasedDate;
//     data['privacy_status'] = this.privacyStatus;
//     data['created_at'] = this.createdAt;
//     return data;
//   }
// }
//
// class Have {
//   int? id;
//   int? userId;
//   String? type;
//   String? name;
//   String? link;
//   String? price;
//   String? photo;
//   String? purchasedDate;
//   String? privacyStatus;
//   String? createdAt;
//
//   Have(
//       {this.id,
//       this.userId,
//       this.type,
//       this.name,
//       this.link,
//       this.price,
//       this.photo,
//       this.purchasedDate,
//       this.privacyStatus,
//       this.createdAt});
//
//   Have.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     type = json['type'];
//     name = json['name'];
//     link = json['link'];
//     price = json['price'];
//     photo = json['photo'];
//     purchasedDate = json['purchased_date'];
//     privacyStatus = json['privacy_status'];
//     createdAt = json['created_at'];
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['type'] = this.type;
//     data['name'] = this.name;
//     data['link'] = this.link;
//     data['price'] = this.price;
//     data['photo'] = this.photo;
//     data['purchased_date'] = this.purchasedDate;
//     data['privacy_status'] = this.privacyStatus;
//     data['created_at'] = this.createdAt;
//     return data;
//   }
// }
//
// class DontWant {
//   int? id;
//   int? userId;
//   String? type;
//   String? name;
//   String? link;
//   String? price;
//   String? photo;
//   String? purchasedDate;
//   String? privacyStatus;
//   String? createdAt;
//
//   DontWant(
//       {this.id,
//       this.userId,
//       this.type,
//       this.name,
//       this.link,
//       this.price,
//       this.photo,
//       this.purchasedDate,
//       this.privacyStatus,
//       this.createdAt});
//
//   DontWant.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     type = json['type'];
//     name = json['name'];
//     link = json['link'];
//     price = json['price'];
//     photo = json['photo'];
//     purchasedDate = json['purchased_date'];
//     privacyStatus = json['privacy_status'];
//     createdAt = json['created_at'];
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['type'] = this.type;
//     data['name'] = this.name;
//     data['link'] = this.link;
//     data['price'] = this.price;
//     data['photo'] = this.photo;
//     data['purchased_date'] = this.purchasedDate;
//     data['privacy_status'] = this.privacyStatus;
//     data['created_at'] = this.createdAt;
//     return data;
//   }
// }

class FriendProductModel {
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

  FriendProductModel(
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

  FriendProductModel.fromJson(Map<String, dynamic> json) {
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