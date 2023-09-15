

class ModelContact {
  int? id;
  String? name;
  String? username;
  String? phone;
  String? email;
  String? photo;

  ModelContact(
      {this.id, this.name, this.username, this.phone, this.email, this.photo});

  ModelContact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    phone = json['phone'];
    email = json['email'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['photo'] = this.photo;
    return data;
  }
}