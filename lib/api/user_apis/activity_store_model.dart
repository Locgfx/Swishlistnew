class ActivityStoreModel {
  int? code;
  bool? status;
  String? message;
  Data? data;

  ActivityStoreModel({this.code, this.status, this.message, this.data});

  ActivityStoreModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  String? leadUserId;
  String? productId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.userId,
        this.leadUserId,
        this.productId,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    leadUserId = json['lead_user_id'];
    productId = json['product_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['lead_user_id'] = this.leadUserId;
    data['product_id'] = this.productId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}

// class ActivityStoreModel {
//   int? code;
//   bool? status;
//   String? message;
//   Data? data;
//
//   ActivityStoreModel({this.code, this.status, this.message, this.data});
//
//   ActivityStoreModel.fromJson(Map<String, dynamic> json) {
//     code = json['code'];
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['code'] = this.code;
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int? userId;
//   String? leadUserId;
//   String? productId;
//   String? updatedAt;
//   String? createdAt;
//   int? id;
//
//   Data(
//       {this.userId,
//         this.leadUserId,
//         this.productId,
//         this.updatedAt,
//         this.createdAt,
//         this.id});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     userId = json['user_id'];
//     leadUserId = json['lead_user_id'];
//     productId = json['product_id'];
//     updatedAt = json['updated_at'];
//     createdAt = json['created_at'];
//     id = json['id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['user_id'] = this.userId;
//     data['lead_user_id'] = this.leadUserId;
//     data['product_id'] = this.productId;
//     data['updated_at'] = this.updatedAt;
//     data['created_at'] = this.createdAt;
//     data['id'] = this.id;
//     return data;
//   }
// }