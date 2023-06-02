// class FriendNotificationModel {
//   int? code;
//   bool? status;
//   String? message;
//   List<Data>? data;
//
//   FriendNotificationModel({this.code, this.status, this.message, this.data});
//
//   FriendNotificationModel.fromJson(Map<String, dynamic> json) {
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
//   User? user;
//   User? friend;
//
//   Data(
//       {this.id,
//         this.userId,
//         this.friendUserId,
//         this.status,
//         this.createdAt,
//         this.user,
//         this.friend});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     friendUserId = json['friend_user_id'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     friend = json['friend'] != null ? new User.fromJson(json['friend']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['friend_user_id'] = this.friendUserId;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
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


class FriendNotificationModel {
  int? id;
  int? userId;
  int? friendUserId;
  String? status;
  String? createdAt;
  User? user;
  User? friend;

  FriendNotificationModel(
      {this.id,
        this.userId,
        this.friendUserId,
        this.status,
        this.createdAt,
        this.user,
        this.friend});

  FriendNotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    friendUserId = json['friend_user_id'];
    status = json['status'];
    createdAt = json['created_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    friend = json['friend'] != null ? new User.fromJson(json['friend']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['friend_user_id'] = this.friendUserId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
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