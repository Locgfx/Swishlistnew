// class MessageModel {
//   int? id;
//   int? chatId;
//   String? message;
//   Product? product;
//   User? user;
//   String? createdAt;
//
//   MessageModel(
//       {this.id,
//         this.chatId,
//         this.message,
//         this.product,
//         this.user,
//         this.createdAt});
//
//   MessageModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     chatId = json['chat_id'];
//     message = json['message'];
//     product =
//     json['product'] != null ? new Product.fromJson(json['product']) : null;
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     createdAt = json['created_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['chat_id'] = this.chatId;
//     data['message'] = this.message;
//     if (this.product != null) {
//       data['product'] = this.product!.toJson();
//     }
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     data['created_at'] = this.createdAt;
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
//   User? user;
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
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
//
// class User {
//   int? id;
//   String? name;
//   String? username;
//   String? email;
//   String? phone;
//   Null? photo;
//   Null? deviceToken;
//   String? fcmToken;
//   String? status;
//   String? complete;
//
//   User(
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
//   User.fromJson(Map<String, dynamic> json) {
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
// class User2 {
//   int? id;
//   String? email;
//   String? photo;
//
//   User2({this.id, this.email, this.photo});
//
//   User2.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     email = json['email'];
//     photo = json['photo'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['email'] = this.email;
//     data['photo'] = this.photo;
//     return data;
//   }
// }


class MessageModel {
  bool? error;
  String? message;
  int? count;
  List<MsgData>? data;

  MessageModel({this.error, this.message, this.count, this.data});

  MessageModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    count = json['count'];
    if (json['data'] != null) {
      data = <MsgData>[];
      json['data'].forEach((v) {
        data!.add(new MsgData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MsgData {
  int? id;
  int? chatId;
  String? message;
  Product? product;
  User? user;
  String? createdAt;

  MsgData(
      {this.id,
        this.chatId,
        this.message,
        this.product,
        this.user,
        this.createdAt});

  MsgData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chatId = json['chat_id'];
    message = json['message'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chat_id'] = this.chatId;
    data['message'] = this.message;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['created_at'] = this.createdAt;
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
  User? user;

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

    data['fcm_token'] = this.fcmToken;
    data['status'] = this.status;
    data['complete'] = this.complete;
    return data;
  }
}

class User2 {
  int? id;
  String? email;
  String? photo;

  User2({this.id, this.email, this.photo});

  User2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['photo'] = this.photo;
    return data;
  }
}

