// class ActivityNotificationModel {
//   int? id;
//   int? userId;
//   String? type;
//   int? familyMemberUserId;
//   int? friendUserId;
//   int? productId;
//   String? createdAt;
//   User? user;
//   User? friend;
//   User? family;
//
//   ActivityNotificationModel(
//       {this.id,
//       this.userId,
//       this.type,
//       this.familyMemberUserId,
//       this.friendUserId,
//       this.productId,
//       this.createdAt,
//       this.user,
//       this.friend,
//       this.family});
//
//   ActivityNotificationModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     type = json['type'];
//     familyMemberUserId = json['family_member_user_id'];
//     friendUserId = json['friend_user_id'];
//     productId = json['product_id'];
//     createdAt = json['created_at'];
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     friend = json['friend'] != null ? new User.fromJson(json['friend']) : null;
//     family = json['family'] != null ? new User.fromJson(json['family']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['type'] = this.type;
//     data['family_member_user_id'] = this.familyMemberUserId;
//     data['friend_user_id'] = this.friendUserId;
//     data['product_id'] = this.productId;
//     data['created_at'] = this.createdAt;
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     if (this.friend != null) {
//       data['friend'] = this.friend!.toJson();
//     }
//     if (this.family != null) {
//       data['family'] = this.family!.toJson();
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
//       this.name,
//       this.username,
//       this.phone,
//       this.email,
//       this.photo,
//       this.type});
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

class ActivityNotificationModel {
  int? id;
  int? userId;
  String? type;
  int? familyMemberUserId;
  int? friendUserId;
  int? productId;
  String? createdAt;
  User? user;
  Product? product;
  User? friend;
  User? family;

  ActivityNotificationModel(
      {this.id,
      this.userId,
      this.type,
      this.familyMemberUserId,
      this.friendUserId,
      this.productId,
      this.createdAt,
      this.user,
      this.product,
      this.friend,
      this.family});

  ActivityNotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    type = json['type'];
    familyMemberUserId = json['family_member_user_id'];
    friendUserId = json['friend_user_id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    friend = json['friend'] != null ? new User.fromJson(json['friend']) : null;
    family = json['family'] != null ? new User.fromJson(json['family']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['family_member_user_id'] = this.familyMemberUserId;
    data['friend_user_id'] = this.friendUserId;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.friend != null) {
      data['friend'] = this.friend!.toJson();
    }
    if (this.family != null) {
      data['family'] = this.family!.toJson();
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

class Product {
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

  Product(
      {this.id,
      this.userId,
      this.type,
      this.name,
      this.link,
      this.price,
      this.photo,
      this.purchasedDate,
      this.privacyStatus,
      this.createdAt});

  Product.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
