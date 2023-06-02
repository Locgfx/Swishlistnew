// // class GetFriendsModel {
// //   int? code;
// //   bool? status;
// //   String? message;
// //   List<Data>? data;
// //
// //   GetFriendsModel({this.code, this.status, this.message, this.data});
// //
// //   GetFriendsModel.fromJson(Map<String, dynamic> json) {
// //     code = json['code'];
// //     status = json['status'];
// //     message = json['message'];
// //     if (json['data'] != null) {
// //       data = <Data>[];
// //       json['data'].forEach((v) {
// //         data!.add( Data.fromJson(v));
// //       });
// //     }
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['code'] = this.code;
// //     data['status'] = this.status;
// //     data['message'] = this.message;
// //     if (this.data != null) {
// //       data['data'] = this.data!.map((v) => v.toJson()).toList();
// //     }
// //     return data;
// //   }
// // }
// //
// // class Data {
// //   int? id;
// //   int? userId;
// //   String? type;
// //   String? name;
// //   String? link;
// //   String? price;
// //   String? photo;
// //   String? purchasedDate;
// //   String? privacyStatus;
// //   String? createdAt;
// //   String? updatedAt;
// //   String? deletedAt;
// //   User? user;
// //
// //   Data(
// //       {this.id,
// //         this.userId,
// //         this.type,
// //         this.name,
// //         this.link,
// //         this.price,
// //         this.photo,
// //         this.purchasedDate,
// //         this.privacyStatus,
// //         this.createdAt,
// //         this.updatedAt,
// //         this.deletedAt,
// //         this.user});
// //
// //   Data.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     userId = json['user_id'];
// //     type = json['type'];
// //     name = json['name'];
// //     link = json['link'];
// //     price = json['price'];
// //     photo = json['photo'];
// //     purchasedDate = json['purchased_date'];
// //     privacyStatus = json['privacy_status'];
// //     createdAt = json['created_at'];
// //     updatedAt = json['updated_at'];
// //     deletedAt = json['deleted_at'].toString();
// //     user = json['user'] != null ?  User.fromJson(json['user']) : null;
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['id'] = this.id;
// //     data['user_id'] = this.userId;
// //     data['type'] = this.type;
// //     data['name'] = this.name;
// //     data['link'] = this.link;
// //     data['price'] = this.price;
// //     data['photo'] = this.photo;
// //     data['purchased_date'] = this.purchasedDate;
// //     data['privacy_status'] = this.privacyStatus;
// //     data['created_at'] = this.createdAt;
// //     data['updated_at'] = this.updatedAt;
// //     data['deleted_at'] = this.deletedAt;
// //     if (this.user != null) {
// //       data['user'] = this.user!.toJson();
// //     }
// //     return data;
// //   }
// // }
// //
// // class User {
// //   int? id;
// //   String? name;
// //   String? username;
// //   String? phone;
// //   String? email;
// //   String? photo;
// //   String? type;
// //
// //   User(
// //       {this.id,
// //         this.name,
// //         this.username,
// //         this.phone,
// //         this.email,
// //         this.photo,
// //         this.type});
// //
// //   User.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     name = json['name'];
// //     username = json['username'];
// //     phone = json['phone'];
// //     email = json['email'];
// //     photo = json['photo'];
// //     type = json['type'];
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['id'] = this.id;
// //     data['name'] = this.name;
// //     data['username'] = this.username;
// //     data['phone'] = this.phone;
// //     data['email'] = this.email;
// //     data['photo'] = this.photo;
// //     data['type'] = this.type;
// //     return data;
// //   }
// // }
//
// class FriendModel {
//   int? code;
//   bool? status;
//   String? message;
//   List<Data>? data;
//
//   FriendModel({this.code, this.status, this.message, this.data});
//
//   FriendModel.fromJson(Map<String, dynamic> json) {
//     code = json['code'];
//     status = json['status'];
//     message = json['message'];
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
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   int? userId;
//   int? friendUserId;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//   String? deletedAt;
//   User? user;
//   Friend? friend;
//
//   Data(
//       {this.id,
//         this.userId,
//         this.friendUserId,
//         this.status,
//         this.createdAt,
//         this.updatedAt,
//         this.deletedAt,
//         this.user,
//         this.friend});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     friendUserId = json['friend_user_id'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = json['deleted_at'].toString();
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     friend =
//     json['friend'] != null ? new Friend.fromJson(json['friend']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['friend_user_id'] = this.friendUserId;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['deleted_at'] = this.deletedAt;
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     if (this.friend != null) {
//       data['friend'] = this.friend!.toJson();
//     }
//     return data;
//   }
// }
//
// class User {
//   int? id;
//   String? name;
//   String? username;
//   String? phone;
//   String? email;
//   String? photo;
//   String? type;
//
//   User(
//       {this.id,
//         this.name,
//         this.username,
//         this.phone,
//         this.email,
//         this.photo,
//         this.type});
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     username = json['username'];
//     phone = json['phone'];
//     email = json['email'];
//     photo = json['photo'];
//     type = json['type'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['username'] = this.username;
//     data['phone'] = this.phone;
//     data['email'] = this.email;
//     data['photo'] = this.photo;
//     data['type'] = this.type;
//     return data;
//   }
// }
//
// class Friend {
//   int? id;
//   String? name;
//   String? username;
//   String? phone;
//   String? email;
//   String? photo;
//   String? type;
//
//   Friend(
//       {this.id,
//         this.name,
//         this.username,
//         this.phone,
//         this.email,
//         this.photo,
//         this.type});
//
//   Friend.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'].toString();
//     username = json['username'].toString();
//     phone = json['phone'].toString();
//     email = json['email'];
//     photo = json['photo'].toString();
//     type = json['type'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['username'] = this.username;
//     data['phone'] = this.phone;
//     data['email'] = this.email;
//     data['photo'] = this.photo;
//     data['type'] = this.type;
//     return data;
//   }
// }
//

class ModelFriend {
  int? id;
  int? userId;
  int? friendUserId;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  User? user;
  Friend? friend;

  ModelFriend(
      {this.id,
        this.userId,
        this.friendUserId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.user,
        this.friend});

  ModelFriend.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    friendUserId = json['friend_user_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'].toString();
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    friend =
    json['friend'] != null ? new Friend.fromJson(json['friend']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['friend_user_id'] = this.friendUserId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.friend != null) {
      data['friend'] = this.friend!.toJson();
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

class Friend {
  int? id;
  String? name;
  String? username;
  String? phone;
  String? email;
  String? photo;
  String? type;

  Friend(
      {this.id,
        this.name,
        this.username,
        this.phone,
        this.email,
        this.photo,
        this.type});

  Friend.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'].toString();
    phone = json['phone'].toString();
    email = json['email'];
    photo = json['photo'].toString();
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