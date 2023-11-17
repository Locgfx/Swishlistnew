// class PetsModel {
//   PetsModel({
//     required this.error,
//     required this.message,
//     required this.count,
//     required this.data,
//   });
//   late final bool error;
//   late final String message;
//   late final int count;
//   late final List<Data> data;
//
//   PetsModel.fromJson(Map<String, dynamic> json){
//     error = json['error'];
//     message = json['message'];
//     count = json['count'];
//     data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['error'] = error;
//     _data['message'] = message;
//     _data['count'] = count;
//     _data['data'] = data.map((e)=>e.toJson()).toList();
//     return _data;
//   }
// }
//
// class Data {
//   Data({
//     required this.id,
//     required this.name,
//     required this.type,
//     required this.origin,
//     required this.photo,
//     required this.privacy,
//     required this.userId,
//     required this.createdAt,
//   });
//   late final int id;
//   late final String name;
//   late final String type;
//   late final String origin;
//   late final String photo;
//   late final String privacy;
//   late final int userId;
//   late final String createdAt;
//
//   Data.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     name = json['name'];
//     type = json['type'];
//     origin = json['origin'];
//     photo = json['photo'];
//     privacy = json['privacy'];
//     userId = json['user_id'];
//     createdAt = json['created_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['name'] = name;
//     _data['type'] = type;
//     _data['origin'] = origin;
//     _data['photo'] = photo;
//     _data['privacy'] = privacy;
//     _data['user_id'] = userId;
//     _data['created_at'] = createdAt;
//     return _data;
//   }
// }

class PetModel {
  int? id;
  String? name;
  String? type;
  String? origin;
  String? photo;
  String? privacy;
  int? userId;
  String? createdAt;

  PetModel(
      {this.id,
        this.name,
        this.type,
        this.origin,
        this.photo,
        this.privacy,
        this.userId,
        this.createdAt});

  PetModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    origin = json['origin'];
    photo = json['photo'];
    privacy = json['privacy'];
    userId = json['user_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['origin'] = this.origin;
    data['photo'] = this.photo;
    data['privacy'] = this.privacy;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    return data;
  }
}
