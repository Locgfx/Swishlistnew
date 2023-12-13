// class FcmNotificationModel {
//   int? code;
//   String? message;
//   bool? status;
//   List<Data>? data;
//
//   FcmNotificationModel({this.code, this.message, this.status, this.data});
//
//   FcmNotificationModel.fromJson(Map<String, dynamic> json) {
//     code = json['code'];
//     message = json['message'];
//     status = json['status'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['code'] = this.code;
//     data['message'] = this.message;
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   String? title;
//   String? message;
//   String? createdAt;
//   User? user;
//   Product? product;
//   User? sendBy;
//
//   Data(
//       {this.id,
//       this.title,
//       this.message,
//       this.createdAt,
//       this.user,
//       this.product,
//       this.sendBy});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     message = json['message'];
//     createdAt = json['created_at'];
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     product =
//         json['product'] != null ? new Product.fromJson(json['product']) : null;
//     sendBy =
//         json['send_by'] != null ? new User.fromJson(json['send_by']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['message'] = this.message;
//     data['created_at'] = this.createdAt;
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     if (this.product != null) {
//       data['product'] = this.product!.toJson();
//     }
//     if (this.sendBy != null) {
//       data['send_by'] = this.sendBy!.toJson();
//     }
//     return data;
//   }
// }
//
// class User {
//   int? id;
//   String? name;
//   String? email;
//   String? phone;
//   String? type;
//   String? photo;
//
//   User({this.id, this.name, this.email, this.phone, this.type, this.photo});
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     type = json['type'];
//     photo = json['photo'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['type'] = this.type;
//     data['photo'] = this.photo;
//     return data;
//   }
// }
//
// class Product {
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
//   Product(
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
//   Product.fromJson(Map<String, dynamic> json) {
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
//
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


class FcmNotificationModel {
  int? id;
  String? title;
  String? message;
  String? createdAt;
  SendTo? sendTo;
  Product? product;
  SendTo? sendBy;

  FcmNotificationModel(
      {this.id,
        this.title,
        this.message,
        this.createdAt,
        this.sendTo,
        this.product,
        this.sendBy});

  FcmNotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    createdAt = json['created_at'];
    sendTo =
    json['send_to'] != null ? new SendTo.fromJson(json['send_to']) : null;
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    sendBy =
    json['send_by'] != null ? new SendTo.fromJson(json['send_by']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    if (this.sendTo != null) {
      data['send_to'] = this.sendTo!.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.sendBy != null) {
      data['send_by'] = this.sendBy!.toJson();
    }
    return data;
  }
}

class SendTo {
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

  SendTo(
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

  SendTo.fromJson(Map<String, dynamic> json) {
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

class Product {
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
  SendTo? user;

  Product(
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

  Product.fromJson(Map<String, dynamic> json) {
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
    user = json['user'] != null ? new SendTo.fromJson(json['user']) : null;
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

//
// class FcmNotificationModel {
//   bool? error;
//   String? message;
//   int? count;
//   List<Data>? data;
//
//   FcmNotificationModel({this.error, this.message, this.count, this.data});
//
//   FcmNotificationModel.fromJson(Map<String, dynamic> json) {
//     error = json['error'];
//     message = json['message'];
//     count = json['count'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['error'] = this.error;
//     data['message'] = this.message;
//     data['count'] = this.count;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   String? title;
//   String? message;
//   String? createdAt;
//   SendTo? sendTo;
//   Product? product;
//   SendTo? sendBy;
//
//   Data(
//       {this.id,
//         this.title,
//         this.message,
//         this.createdAt,
//         this.sendTo,
//         this.product,
//         this.sendBy});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     message = json['message'];
//     createdAt = json['created_at'];
//     sendTo =
//     json['send_to'] != null ? new SendTo.fromJson(json['send_to']) : null;
//     product =
//     json['product'] != null ? new Product.fromJson(json['product']) : null;
//     sendBy =
//     json['send_by'] != null ? new SendTo.fromJson(json['send_by']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['message'] = this.message;
//     data['created_at'] = this.createdAt;
//     if (this.sendTo != null) {
//       data['send_to'] = this.sendTo!.toJson();
//     }
//     if (this.product != null) {
//       data['product'] = this.product!.toJson();
//     }
//     if (this.sendBy != null) {
//       data['send_by'] = this.sendBy!.toJson();
//     }
//     return data;
//   }
// }
//
// class SendTo {
//   int? id;
//   String? name;
//   String? username;
//   String? email;
//   String? phone;
//   String? photo;
//   String? fcmToken;
//   String? status;
//   String? complete;
//
//   SendTo(
//       {this.id,
//         this.name,
//         this.username,
//         this.email,
//         this.phone,
//         this.photo,
//         this.fcmToken,
//         this.status,
//         this.complete});
//
//   SendTo.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     username = json['username'];
//     email = json['email'];
//     phone = json['phone'];
//     photo = json['photo'];
//     fcmToken = json['fcm_token'];
//     status = json['status'];
//     complete = json['complete'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['username'] = this.username;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['photo'] = this.photo;
//     data['fcm_token'] = this.fcmToken;
//     data['status'] = this.status;
//     data['complete'] = this.complete;
//     return data;
//   }
// }
//
// class Product {
//   int? id;
//   String? type;
//   String? name;
//   String? url;
//   String? price;
//   String? description;
//   String? photo;
//   String? purchasedOn;
//   String? privacy;
//   String? lastUpdated;
//   SendTo? user;
//
//   Product(
//       {this.id,
//         this.type,
//         this.name,
//         this.url,
//         this.price,
//         this.description,
//         this.photo,
//         this.purchasedOn,
//         this.privacy,
//         this.lastUpdated,
//         this.user});
//
//   Product.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     type = json['type'];
//     name = json['name'];
//     url = json['url'];
//     price = json['price'];
//     description = json['description'];
//     photo = json['photo'];
//     purchasedOn = json['purchased_on'];
//     privacy = json['privacy'];
//     lastUpdated = json['last_updated'];
//     user = json['user'] != null ? new SendTo.fromJson(json['user']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['type'] = this.type;
//     data['name'] = this.name;
//     data['url'] = this.url;
//     data['price'] = this.price;
//     data['description'] = this.description;
//     data['photo'] = this.photo;
//     data['purchased_on'] = this.purchasedOn;
//     data['privacy'] = this.privacy;
//     data['last_updated'] = this.lastUpdated;
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     return data;
//   }
// }
// class FcmNotificationModel {
//   int? id;
//   String? title;
//   String? message;
//   String? createdAt;
//   SendTo? sendTo;
//   Null? product;
//   SendBy? sendBy;
//
//   FcmNotificationModel(
//       {this.id,
//         this.title,
//         this.message,
//         this.createdAt,
//         this.sendTo,
//         this.product,
//         this.sendBy});
//
//   FcmNotificationModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     message = json['message'];
//     createdAt = json['created_at'];
//     sendTo =
//     json['send_to'] != null ? new SendTo.fromJson(json['send_to']) : null;
//     product = json['product'];
//     sendBy =
//     json['send_by'] != null ? new SendBy.fromJson(json['send_by']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['message'] = this.message;
//     data['created_at'] = this.createdAt;
//     if (this.sendTo != null) {
//       data['send_to'] = this.sendTo!.toJson();
//     }
//     data['product'] = this.product;
//     if (this.sendBy != null) {
//       data['send_by'] = this.sendBy!.toJson();
//     }
//     return data;
//   }
// }
//
// class SendTo {
//   int? id;
//   Null? name;
//   String? username;
//   String? email;
//   String? phone;
//   Null? photo;
//   Null? deviceToken;
//   String? fcmToken;
//   String? status;
//   String? complete;
//
//   SendTo(
//       {this.id,
//         this.name,
//         this.username,
//         this.email,
//         this.phone,
//         this.photo,
//         this.deviceToken,
//         this.fcmToken,
//         this.status,
//         this.complete});
//
//   SendTo.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     username = json['username'];
//     email = json['email'];
//     phone = json['phone'];
//     photo = json['photo'];
//     deviceToken = json['device_token'];
//     fcmToken = json['fcm_token'];
//     status = json['status'];
//     complete = json['complete'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['username'] = this.username;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['photo'] = this.photo;
//     data['device_token'] = this.deviceToken;
//     data['fcm_token'] = this.fcmToken;
//     data['status'] = this.status;
//     data['complete'] = this.complete;
//     return data;
//   }
// }
//
// class SendBy {
//   int? id;
//   String? name;
//   String? username;
//   String? email;
//   String? phone;
//   String? photo;
//   Null? deviceToken;
//   String? fcmToken;
//   String? status;
//   String? complete;
//
//   SendBy(
//       {this.id,
//         this.name,
//         this.username,
//         this.email,
//         this.phone,
//         this.photo,
//         this.deviceToken,
//         this.fcmToken,
//         this.status,
//         this.complete});
//
//   SendBy.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     username = json['username'];
//     email = json['email'];
//     phone = json['phone'];
//     photo = json['photo'];
//     deviceToken = json['device_token'];
//     fcmToken = json['fcm_token'];
//     status = json['status'];
//     complete = json['complete'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['username'] = this.username;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['photo'] = this.photo;
//     data['device_token'] = this.deviceToken;
//     data['fcm_token'] = this.fcmToken;
//     data['status'] = this.status;
//     data['complete'] = this.complete;
//     return data;
//   }
// }
