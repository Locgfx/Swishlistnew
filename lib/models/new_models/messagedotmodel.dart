class MessageDotModel {
  int? id;
  int? messageId;
  int? sendFromUserId;
  int? sendToUserId;
  String? message;
  String? createdAt;
  int? productId;
  Product? product;

  MessageDotModel(
      {this.id,
      this.messageId,
      this.sendFromUserId,
      this.sendToUserId,
      this.message,
      this.createdAt,
      this.productId,
      this.product});

  MessageDotModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    messageId = json['message_id'];
    sendFromUserId = json['send_from_user_id'];
    sendToUserId = json['send_to_user_id'];
    message = json['message'];
    createdAt = json['created_at'];
    productId = json['product_id'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message_id'] = this.messageId;
    data['send_from_user_id'] = this.sendFromUserId;
    data['send_to_user_id'] = this.sendToUserId;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    data['product_id'] = this.productId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
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
