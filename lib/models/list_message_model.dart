class ListMessageModel {
  int? code;
  bool? status;
  String? message;
  List<Data>? data;

  ListMessageModel({this.code, this.status, this.message, this.data});

  ListMessageModel.fromJson(Map<String, dynamic> json) {
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
  int? messageId;
  int? sendFromUserId;
  int? sendToUserId;
  String? message;
  String? createdAt;

  Data(
      {this.id,
        this.messageId,
        this.sendFromUserId,
        this.sendToUserId,
        this.message,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
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