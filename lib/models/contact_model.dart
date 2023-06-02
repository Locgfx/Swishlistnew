// class ContactModel {
//   int? code;
//   bool? status;
//   String? message;
//   List<Data>? data;
//
//   ContactModel({this.code, this.status, this.message, this.data});
//
//   ContactModel.fromJson(Map<String, dynamic> json) {
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
//   String? name;
//   String? username;
//   String? phone;
//   String? email;
//   String? photo;
//
//   Data({this.id, this.name, this.username, this.phone, this.email, this.photo});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     username = json['username'];
//     phone = json['phone'];
//     email = json['email'];
//     photo = json['photo'];
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
//     return data;
//   }
// }

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