class FamilyMemberRequestIndexModel {
  int? id;
  String? status;
  RequestBy? requestBy;
  String? createdAt;

  FamilyMemberRequestIndexModel(
      {this.id, this.status, this.requestBy, this.createdAt});

  FamilyMemberRequestIndexModel.fromJson(Map<String, dynamic> json) {
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