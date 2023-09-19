// class FavouritesModel {
//   int? code;
//   bool? status;
//   String? message;
//   Data? data;
//
//   FavouritesModel({this.code, this.status, this.message, this.data});
//
//   FavouritesModel.fromJson(Map<String, dynamic> json) {
//     code = json['code'];
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] == []
//         ? null
//         : json['data'] != null
//             ? Data.fromJson(json['data'])
//             : null;
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
//   int? id;
//   int? userId;
//   String? cars;
//   String? bikes;
//   String? movies;
//   String? shows;
//   String? foods;
//   String? gadgets;
//   String? superheroes;
//   String? actors;
//   String? actresses;
//   String? singers;
//   String? players;
//   String? cities;
//   String? countries;
//   String? restaurants;
//   String? hotels;
//   String? privacyStatus;
//   String? createdAt;
//   String? updatedAt;
//   String? deletedAt;
//   User? user;
//
//   Data(
//       {this.id,
//       this.userId,
//       this.cars,
//       this.bikes,
//       this.movies,
//       this.shows,
//       this.foods,
//       this.gadgets,
//       this.superheroes,
//       this.actors,
//       this.actresses,
//       this.singers,
//       this.players,
//       this.cities,
//       this.countries,
//       this.restaurants,
//       this.hotels,
//       this.privacyStatus,
//       this.createdAt,
//       this.updatedAt,
//       this.deletedAt,
//       this.user});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     cars = json['cars'];
//     bikes = json['bikes'];
//     movies = json['movies'];
//     shows = json['shows'];
//     foods = json['foods'];
//     gadgets = json['gadgets'];
//     superheroes = json['superheroes'];
//     actors = json['actors'];
//     actresses = json['actresses'];
//     singers = json['singers'];
//     players = json['players'];
//     cities = json['cities'];
//     countries = json['countries'];
//     restaurants = json['restaurants'];
//     hotels = json['hotels'];
//     privacyStatus = json['privacy_status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = json['deleted_at'].toString();
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['cars'] = this.cars;
//     data['bikes'] = this.bikes;
//     data['movies'] = this.movies;
//     data['shows'] = this.shows;
//     data['foods'] = this.foods;
//     data['gadgets'] = this.gadgets;
//     data['superheroes'] = this.superheroes;
//     data['actors'] = this.actors;
//     data['actresses'] = this.actresses;
//     data['singers'] = this.singers;
//     data['players'] = this.players;
//     data['cities'] = this.cities;
//     data['countries'] = this.countries;
//     data['restaurants'] = this.restaurants;
//     data['hotels'] = this.hotels;
//     data['privacy_status'] = this.privacyStatus;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['deleted_at'] = this.deletedAt;
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     return data;
//   }
// }
//
// class User {
//   int? id;
//   String? name;
//   String? username;
//   String? phone;
//   String? email;
//   String? photo;
//   String? type;
//
//   User(
//       {this.id,
//       this.name,
//       this.username,
//       this.phone,
//       this.email,
//       this.photo,
//       this.type});
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     username = json['username'];
//     phone = json['phone'];
//     email = json['email'];
//     photo = json['photo'];
//     type = json['type'];
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
//     data['type'] = this.type;
//     return data;
//   }
// }

class FavouritesModel {
  int? code;
  bool? status;
  String? message;
  Data? data;

  FavouritesModel({this.code, this.status, this.message, this.data});

  FavouritesModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? userId;
  String? cars;
  String? bikes;
  String? movies;
  String? shows;
  String? foods;
  String? gadgets;
  String? superheroes;
  String? actors;
  String? actresses;
  String? singers;
  String? players;
  String? cities;
  String? countries;
  String? restaurants;
  String? hotels;
  String? privacyStatus;
  String? completePercent;
  String? createdAt;
  User? user;

  Data(
      {this.id,
      this.userId,
      this.cars,
      this.bikes,
      this.movies,
      this.shows,
      this.foods,
      this.gadgets,
      this.superheroes,
      this.actors,
      this.actresses,
      this.singers,
      this.players,
      this.cities,
      this.countries,
      this.restaurants,
      this.hotels,
      this.privacyStatus,
      this.completePercent,
      this.createdAt,
      this.user});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    cars = json['cars'];
    bikes = json['bikes'];
    movies = json['movies'];
    shows = json['shows'];
    foods = json['foods'];
    gadgets = json['gadgets'];
    superheroes = json['superheroes'];
    actors = json['actors'];
    actresses = json['actresses'];
    singers = json['singers'];
    players = json['players'];
    cities = json['cities'];
    countries = json['countries'];
    restaurants = json['restaurants'];
    hotels = json['hotels'];
    privacyStatus = json['privacy_status'];
    completePercent = json['complete_percent'];
    createdAt = json['created_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['cars'] = this.cars;
    data['bikes'] = this.bikes;
    data['movies'] = this.movies;
    data['shows'] = this.shows;
    data['foods'] = this.foods;
    data['gadgets'] = this.gadgets;
    data['superheroes'] = this.superheroes;
    data['actors'] = this.actors;
    data['actresses'] = this.actresses;
    data['singers'] = this.singers;
    data['players'] = this.players;
    data['cities'] = this.cities;
    data['countries'] = this.countries;
    data['restaurants'] = this.restaurants;
    data['hotels'] = this.hotels;
    data['privacy_status'] = this.privacyStatus;
    data['complete_percent'] = this.completePercent;
    data['created_at'] = this.createdAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? username;
  String? phone;
  String? email;
  String? photo;
  String? type;

  User(
      {this.id,
      this.name,
      this.username,
      this.phone,
      this.email,
      this.photo,
      this.type});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    phone = json['phone'];
    email = json['email'];
    photo = json['photo'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['photo'] = this.photo;
    data['type'] = this.type;
    return data;
  }
}
