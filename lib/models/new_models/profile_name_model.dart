class ProfileNameModel {
  int? id;
  int? userId;
  String? name;
  String? photo;
  String? email;

  ProfileNameModel({this.id, this.userId, this.name, this.photo, this.email});

  ProfileNameModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    photo = json['photo'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['email'] = this.email;
    return data;
  }
}
