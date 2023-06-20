class MessageModel {
  int? code;
  bool? status;
  String? message;
  List<Data>? data;

  MessageModel({this.code, this.status, this.message, this.data});

  MessageModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? usersIds;
  String? createdAt;
  FriendProfile? friendProfile;
  List<UserMessages>? userMessages;

  Data(
      {this.id,
        this.usersIds,
        this.createdAt,
        this.friendProfile,
        this.userMessages});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usersIds = json['users_ids'];
    createdAt = json['created_at'];
    friendProfile = json['friendProfile'] != null
        ? new FriendProfile.fromJson(json['friendProfile'])
        :FriendProfile(
        name: '',
        photo: '');
    if (json['userMessages'] != null) {
      userMessages = <UserMessages>[];
      json['userMessages'].forEach((v) {
        userMessages!.add(new UserMessages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['users_ids'] = this.usersIds;
    data['created_at'] = this.createdAt;
    if (this.friendProfile != null) {
      data['friendProfile'] = this.friendProfile!.toJson();
    }
    if (this.userMessages != null) {
      data['userMessages'] = this.userMessages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FriendProfile {
  String? name;
  String? photo;

  FriendProfile({this.name, this.photo});

  FriendProfile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['photo'] = this.photo;
    return data;
  }
}

class UserMessages {
  int? id;
  int? messageId;
  int? sendFromUserId;
  int? sendToUserId;
  String? message;
  String? createdAt;

  UserMessages(
      {this.id,
        this.messageId,
        this.sendFromUserId,
        this.sendToUserId,
        this.message,
        this.createdAt});

  UserMessages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    messageId = json['message_id'];
    sendFromUserId = json['send_from_user_id'];
    sendToUserId = json['send_to_user_id'];
    message = json['message'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message_id'] = this.messageId;
    data['send_from_user_id'] = this.sendFromUserId;
    data['send_to_user_id'] = this.sendToUserId;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    return data;
  }
}



// class MessageModel {
//   int? id;
//   String? usersIds;
//   String? createdAt;
//   FriendProfile? friendProfile;
//   List<UserMessages>? userMessages;
//
//   MessageModel(
//       {this.id,
//         this.usersIds,
//         this.createdAt,
//         this.friendProfile,
//         this.userMessages});
//
//   MessageModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     usersIds = json['users_ids'];
//     createdAt = json['created_at'];
//     friendProfile = json['friendProfile'] != null
//         ? new FriendProfile.fromJson(json['friendProfile'])
//         : null;
//     if (json['userMessages'] != null) {
//       userMessages = <UserMessages>[];
//       json['userMessages'].forEach((v) {
//         userMessages!.add(new UserMessages.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['users_ids'] = this.usersIds;
//     data['created_at'] = this.createdAt;
//     if (this.friendProfile != null) {
//       data['friendProfile'] = this.friendProfile!.toJson();
//     }
//     if (this.userMessages != null) {
//       data['userMessages'] = this.userMessages!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class FriendProfile {
//   String? name;
//   String? photo;
//
//   FriendProfile({this.name, this.photo});
//
//   FriendProfile.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     photo = json['photo'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['photo'] = this.photo;
//     return data;
//   }
// }
//
// class UserMessages {
//   int? id;
//   int? messageId;
//   int? sendFromUserId;
//   int? sendToUserId;
//   String? message;
//   String? createdAt;
//
//   UserMessages(
//       {this.id,
//         this.messageId,
//         this.sendFromUserId,
//         this.sendToUserId,
//         this.message,
//         this.createdAt});
//
//   UserMessages.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     messageId = json['message_id'];
//     sendFromUserId = json['send_from_user_id'];
//     sendToUserId = json['send_to_user_id'];
//     message = json['message'];
//     createdAt = json['created_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['message_id'] = this.messageId;
//     data['send_from_user_id'] = this.sendFromUserId;
//     data['send_to_user_id'] = this.sendToUserId;
//     data['message'] = this.message;
//     data['created_at'] = this.createdAt;
//     return data;
//   }
// }
