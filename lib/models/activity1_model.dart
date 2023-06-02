// // class Activity1 {
// //   Activity1({
// //     required this.code,
// //     required this.status,
// //     required this.message,
// //     required this.data,
// //   });
// //   late final int code;
// //   late final bool status;
// //   late final String message;
// //   late final List<Data> data;
// //
// //   Activity1.fromJson(Map<String, dynamic> json) {
// //     code = json['code'];
// //     status = json['status'];
// //     message = json['message'];
// //     data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final _data = <String, dynamic>{};
// //     _data['code'] = code;
// //     _data['status'] = status;
// //     _data['message'] = message;
// //     _data['data'] = data.map((e) => e.toJson()).toList();
// //     return _data;
// //   }
// // }
// //
// // class Data {
// //   Data({
// //     required this.id,
// //     required this.userId,
// //     required this.leadUserId,
// //     required this.productId,
// //     required this.createdAt,
// //     required this.updatedAt,
// //     this.deletedAt,
// //     required this.user,
// //     required this.leadUser,
// //     this.product,
// //   });
// //   late final int id;
// //   late final int userId;
// //   late final int leadUserId;
// //   late final int productId;
// //   late final String createdAt;
// //   late final String updatedAt;
// //   late final Null deletedAt;
// //   late final User user;
// //   late final LeadUser leadUser;
// //   late final Null product;
// //
// //   Data.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     userId = json['user_id'];
// //     leadUserId = json['lead_user_id'];
// //     productId = json['product_id'];
// //     createdAt = json['created_at'];
// //     updatedAt = json['updated_at'];
// //     deletedAt = null;
// //     user = User.fromJson(json['user']);
// //     leadUser = LeadUser.fromJson(json['lead_user']);
// //     product = null;
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final _data = <String, dynamic>{};
// //     _data['id'] = id;
// //     _data['user_id'] = userId;
// //     _data['lead_user_id'] = leadUserId;
// //     _data['product_id'] = productId;
// //     _data['created_at'] = createdAt;
// //     _data['updated_at'] = updatedAt;
// //     _data['deleted_at'] = deletedAt;
// //     _data['user'] = user.toJson();
// //     _data['lead_user'] = leadUser.toJson();
// //     _data['product'] = product;
// //     return _data;
// //   }
// // }
// //
// // class User {
// //   User({
// //     required this.id,
// //     required this.name,
// //     required this.username,
// //     required this.phone,
// //     required this.email,
// //     required this.photo,
// //     required this.type,
// //   });
// //   late final int id;
// //   late final String name;
// //   late final String username;
// //   late final String phone;
// //   late final String email;
// //   late final String photo;
// //   late final String type;
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
// //     final _data = <String, dynamic>{};
// //     _data['id'] = id;
// //     _data['name'] = name;
// //     _data['username'] = username;
// //     _data['phone'] = phone;
// //     _data['email'] = email;
// //     _data['photo'] = photo;
// //     _data['type'] = type;
// //     return _data;
// //   }
// // }
// //
// // class LeadUser {
// //   LeadUser({
// //     required this.id,
// //     this.name,
// //     this.username,
// //     this.phone,
// //     required this.email,
// //     this.photo,
// //     required this.type,
// //   });
// //   late final int id;
// //   late final Null name;
// //   late final Null username;
// //   late final Null phone;
// //   late final String email;
// //   late final Null photo;
// //   late final String type;
// //
// //   LeadUser.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     name = null;
// //     username = null;
// //     phone = null;
// //     email = json['email'];
// //     photo = null;
// //     type = json['type'];
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final _data = <String, dynamic>{};
// //     _data['id'] = id;
// //     _data['name'] = name;
// //     _data['username'] = username;
// //     _data['phone'] = phone;
// //     _data['email'] = email;
// //     _data['photo'] = photo;
// //     _data['type'] = type;
// //     return _data;
// //   }
// // }
// //
// //
//
// class Activity1 {
//   int? code;
//   bool? status;
//   String? message;
//   List<Data>? data;
//
//   Activity1({this.code, this.status, this.message, this.data});
//
//   Activity1.fromJson(Map<String, dynamic> json) {
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
//   String? type;
//   String? name;
//   String? link;
//   String? price;
//   String? photo;
//   String? purchasedDate;
//   String? privacyStatus;
//   String? createdAt;
//   User? user;
//
//   Data(
//       {this.id,
//         this.userId,
//         this.type,
//         this.name,
//         this.link,
//         this.price,
//         this.photo,
//         this.purchasedDate,
//         this.privacyStatus,
//         this.createdAt,
//         this.user});
//
//   Data.fromJson(Map<String, dynamic> json) {
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
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
//

class Activity1 {
  int? code;
  bool? status;
  String? message;
  List<Data>? data;

  Activity1({this.code, this.status, this.message, this.data});

  Activity1.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  int? leadUserId;
  int? productId;
  String? createdAt;
  User? user;
  LeadUser? leadUser;
  String? product;

  Data(
      {this.id,
        this.userId,
        this.leadUserId,
        this.productId,
        this.createdAt,
        this.user,
        this.leadUser,
        this.product});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    leadUserId = json['lead_user_id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    leadUser = json['lead_user'] != null
        ? new LeadUser.fromJson(json['lead_user'])
        : null;
    product = json['product'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['lead_user_id'] = this.leadUserId;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.leadUser != null) {
      data['lead_user'] = this.leadUser!.toJson();
    }
    data['product'] = this.product;
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

class LeadUser {
  int? id;
  String? name;
  String? username;
  String? phone;
  String? email;
  String? photo;
  String? type;

  LeadUser(
      {this.id,
        this.name,
        this.username,
        this.phone,
        this.email,
        this.photo,
        this.type});

  LeadUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'].toString();
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