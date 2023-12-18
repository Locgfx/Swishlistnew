class FriendFavoriteModel {
  bool? error;
  String? message;
  Data? data;

  FriendFavoriteModel({this.error, this.message, this.data});

  FriendFavoriteModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? email;
  Null? token;
  String? fcmToken;
  String? status;
  Favourites? favourites;

  Data(
      {this.id,
        this.name,
        this.email,
        this.token,
        this.fcmToken,
        this.status,
        this.favourites});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    token = json['token'];
    fcmToken = json['fcm_token'];
    status = json['status'];
    favourites = json['favourites'] != null
        ? new Favourites.fromJson(json['favourites'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['token'] = this.token;
    data['fcm_token'] = this.fcmToken;
    data['status'] = this.status;
    if (this.favourites != null) {
      data['favourites'] = this.favourites!.toJson();
    }
    return data;
  }
}

class Favourites {
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

  Favourites(
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

  Favourites.fromJson(Map<String, dynamic> json) {
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
