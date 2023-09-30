class FriendEventDateModel {
  int? id;
  int? userId;
  String? name;
  String? date;
  String? type;
  String? privacyStatus;
  String? createdAt;

  FriendEventDateModel(
      {this.id,
      this.userId,
      this.name,
      this.date,
      this.type,
      this.privacyStatus,
      this.createdAt});

  FriendEventDateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    date = json['date'];
    type = json['type'];
    privacyStatus = json['privacy_status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['date'] = this.date;
    data['type'] = this.type;
    data['privacy_status'] = this.privacyStatus;
    data['created_at'] = this.createdAt;
    return data;
  }
}
