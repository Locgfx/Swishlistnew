class FriendNonNullModel {
  int? code;
  bool? status;
  String? message;
  Data? data;

  FriendNonNullModel({this.code, this.status, this.message, this.data});

  FriendNonNullModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Want>? want;
  List<Have>? have;
  List<DontWant>? dontWant;

  Data({this.want, this.have, this.dontWant});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['want'] != null) {
      want = <Want>[];
      json['want'].forEach((v) {
        want!.add(new Want.fromJson(v));
      });
    }
    if (json['have'] != null) {
      have = <Have>[];
      json['have'].forEach((v) {
        have!.add(new Have.fromJson(v));
      });
    }
    if (json['dont_want'] != null) {
      dontWant = <DontWant>[];
      json['dont_want'].forEach((v) {
        dontWant!.add(new DontWant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.want != null) {
      data['want'] = this.want!.map((v) => v.toJson()).toList();
    }
    if (this.have != null) {
      data['have'] = this.have!.map((v) => v.toJson()).toList();
    }
    if (this.dontWant != null) {
      data['dont_want'] = this.dontWant!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Want {
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

  Want(
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

  Want.fromJson(Map<String, dynamic> json) {
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

class Have {
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

  Have(
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

  Have.fromJson(Map<String, dynamic> json) {
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

class DontWant {
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

  DontWant(
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

  DontWant.fromJson(Map<String, dynamic> json) {
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
