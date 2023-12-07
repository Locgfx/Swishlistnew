// class FavouritesModel {
//   bool? error;
//   String? message;
//   Data? data;
//
//   FavouritesModel({this.error, this.message, this.data});
//
//   FavouritesModel.fromJson(Map<String, dynamic> json) {
//     error = json['error'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['error'] = this.error;
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
//   List<String>? cars;
//   List<String>? bikes;
//   List<String>? movies;
//   List<String>? shows;
//   List<String>? foods;
//   List<String>? gadgets;
//   List<String>? superheroes;
//   List<String>? actors;
//   List<String>? actresses;
//   List<String>? singers;
//   List<String>? players;
//   List<String>? cities;
//   List<String>? countries;
//   List<String>? restaurants;
//   List<String>? hotels;
//   String? privacy;
//
//   Data(
//       {this.id,
//         this.cars,
//         this.bikes,
//         this.movies,
//         this.shows,
//         this.foods,
//         this.gadgets,
//         this.superheroes,
//         this.actors,
//         this.actresses,
//         this.singers,
//         this.players,
//         this.cities,
//         this.countries,
//         this.restaurants,
//         this.hotels,
//         this.privacy});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     cars = json['cars'].cast<String>();
//     bikes = json['bikes'].cast<String>();
//     movies = json['movies'].cast<String>();
//     shows = json['shows'].cast<String>();
//     foods = json['foods'].cast<String>();
//     gadgets = json['gadgets'].cast<String>();
//     superheroes = json['superheroes'].cast<String>();
//     actors = json['actors'].cast<String>();
//     actresses = json['actresses'].cast<String>();
//     singers = json['singers'].cast<String>();
//     players = json['players'].cast<String>();
//     cities = json['cities'].cast<String>();
//     countries = json['countries'].cast<String>();
//     restaurants = json['restaurants'].cast<String>();
//     hotels = json['hotels'].cast<String>();
//     privacy = json['privacy'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
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
//     data['privacy'] = this.privacy;
//     return data;
//   }
// }

class FavouritesModel {
  bool? error;
  String? message;
  Data? data;

  FavouritesModel({this.error, this.message, this.data});

  FavouritesModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  List<String>? cars;
  List<String>? bikes;
  List<String>? movies;
  List<String>? shows;
  List<String>? foods;
  List<String>? gadgets;
  List<String>? superheroes;
  List<String>? actors;
  List<String>? actresses;
  List<String>? singers;
  List<String>? players;
  List<String>? cities;
  List<String>? countries;
  List<String>? restaurants;
  List<String>? hotels;
  String? privacy;
  String? complete;

  Data(
      {this.id,
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
        this.privacy,
        this.complete});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cars = json['cars'].cast<String>();
    bikes = json['bikes'].cast<String>();
    movies = json['movies'].cast<String>();
    shows = json['shows'].cast<String>();
    foods = json['foods'].cast<String>();
    gadgets = json['gadgets'].cast<String>();
    superheroes = json['superheroes'].cast<String>();
    actors = json['actors'].cast<String>();
    actresses = json['actresses'].cast<String>();
    singers = json['singers'].cast<String>();
    players = json['players'].cast<String>();
    cities = json['cities'].cast<String>();
    countries = json['countries'].cast<String>();
    restaurants = json['restaurants'].cast<String>();
    hotels = json['hotels'].cast<String>();
    privacy = json['privacy'];
    complete = json['complete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    data['privacy'] = this.privacy;
    data['complete'] = this.complete;
    return data;
  }
}
