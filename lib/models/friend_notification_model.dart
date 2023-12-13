//
// class FriendNotificationModel {
//   int? id;
//   int? userId;
//   int? friendUserId;
//   String? status;
//   String? createdAt;
//   User? user;
//   User? friend;
//
//   FriendNotificationModel(
//       {this.id,
//         this.userId,
//         this.friendUserId,
//         this.status,
//         this.createdAt,
//         this.user,
//         this.friend});
//
//   FriendNotificationModel.fromJson(Map<String, dynamic> json) {
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


class FriendRequestNotificationModel {
  int? id;
  String? status;
  RequestBy? requestBy;
  String? createdAt;

  FriendRequestNotificationModel(
      {this.id, this.status, this.requestBy, this.createdAt});

  FriendRequestNotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    requestBy = json['request_by'] != null
        ? new RequestBy.fromJson(json['request_by'])
        : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    if (this.requestBy != null) {
      data['request_by'] = this.requestBy!.toJson();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class RequestBy {
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

  RequestBy(
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

  RequestBy.fromJson(Map<String, dynamic> json) {
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
