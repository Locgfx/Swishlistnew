class UserDetailsModel {
  bool? error;
  String? message;
  Data? data;

  UserDetailsModel({this.error, this.message, this.data});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? status;
  Profile? profile;
  Sizing? sizing;
  List<Pets>? pets;
  List<Events>? events;
  Favourites? favourites;
  List<Interests>? interests;
  List<Addresses>? addresses;

  Data(
      {this.id,
        this.name,
        this.email,

        this.status,
        this.profile,
        this.sizing,
        this.pets,
        this.events,
        this.favourites,
        this.interests,
        this.addresses});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];

    status = json['status'];
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;

    sizing =
    json['sizing'] != null ? new Sizing.fromJson(json['sizing']) : null;
    if (json['pets'] != null) {
      pets = <Pets>[];
      json['pets'].forEach((v) {
        pets!.add(new Pets.fromJson(v));
      });
    }
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(new Events.fromJson(v));
      });
    }
    favourites = json['favourites'] != null
        ? new Favourites.fromJson(json['favourites'])
        : null;
    if (json['interests'] != null) {
      interests = <Interests>[];
      json['interests'].forEach((v) {
        interests!.add(new Interests.fromJson(v));
      });
    }
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(new Addresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;

    data['status'] = this.status;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }

    if (this.sizing != null) {
      data['sizing'] = this.sizing!.toJson();
    }
    if (this.pets != null) {
      data['pets'] = this.pets!.map((v) => v.toJson()).toList();
    }
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    if (this.favourites != null) {
      data['favourites'] = this.favourites!.toJson();
    }
    if (this.interests != null) {
      data['interests'] = this.interests!.map((v) => v.toJson()).toList();
    }
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Profile {
  String? username;
  String? gender;
  String? marritalStatus;
  String? dateOfBirth;
  String? occupation;
  String? phone;
  String? additionalPhone;
  String? privacy;
  String? photo;

  Profile(
      {this.username,
        this.gender,
        this.marritalStatus,
        this.dateOfBirth,
        this.occupation,
        this.phone,
        this.additionalPhone,
        this.privacy,
        this.photo});

  Profile.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    gender = json['gender'];
    marritalStatus = json['marrital_status'];
    dateOfBirth = json['date_of_birth'];
    occupation = json['occupation'];
    phone = json['phone'];
    additionalPhone = json['additional_phone'];
    privacy = json['privacy'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['gender'] = this.gender;
    data['marrital_status'] = this.marritalStatus;
    data['date_of_birth'] = this.dateOfBirth;
    data['occupation'] = this.occupation;
    data['phone'] = this.phone;
    data['additional_phone'] = this.additionalPhone;
    data['privacy'] = this.privacy;
    data['photo'] = this.photo;
    return data;
  }
}

class Sizing {
  int? id;
  String? waist;
  String? shirt;
  String? shoe;
  String? bed;
  String? privacy;
  String? complete;

  Sizing(
      {this.id,
        this.waist,
        this.shirt,
        this.shoe,
        this.bed,
        this.privacy,
        this.complete});

  Sizing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    waist = json['waist'];
    shirt = json['shirt'];
    shoe = json['shoe'];
    bed = json['bed'];
    privacy = json['privacy'];
    complete = json['complete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['waist'] = this.waist;
    data['shirt'] = this.shirt;
    data['shoe'] = this.shoe;
    data['bed'] = this.bed;
    data['privacy'] = this.privacy;
    data['complete'] = this.complete;
    return data;
  }
}

class Pets {
  int? id;
  String? name;
  String? type;
  String? origin;
  String? photo;
  String? privacy;
  String? createdAt;
  String? updatedAt;
  String? complete;

  Pets(
      {this.id,
        this.name,
        this.type,
        this.origin,
        this.photo,
        this.privacy,
        this.createdAt,
        this.updatedAt,
        this.complete});

  Pets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    origin = json['origin'];
    photo = json['photo'];
    privacy = json['privacy'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    complete = json['complete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['origin'] = this.origin;
    data['photo'] = this.photo;
    data['privacy'] = this.privacy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['complete'] = this.complete;
    return data;
  }
}

class Events {
  int? id;
  String? name;
  String? date;
  String? time;
  String? privacy;
  String? type;

  Events({this.id, this.name, this.date, this.time, this.privacy, this.type});

  Events.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    date = json['date'];
    time = json['time'];
    privacy = json['privacy'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['date'] = this.date;
    data['time'] = this.time;
    data['privacy'] = this.privacy;
    data['type'] = this.type;
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

class Interests {
  int? id;
  List<String>? interests;
  String? privacy;

  Interests({this.id, this.interests, this.privacy});

  Interests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    interests = json['interests'].cast<String>();
    privacy = json['privacy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['interests'] = this.interests;
    data['privacy'] = this.privacy;
    return data;
  }
}

class Addresses {
  int? id;
  String? streetOne;
  String? streetTwo;
  String? city;
  String? state;
  String? zip;
  String? country;
  String? type;
  String? complete;

  Addresses(
      {this.id,
        this.streetOne,
        this.streetTwo,
        this.city,
        this.state,
        this.zip,
        this.country,
        this.type,
        this.complete});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    streetOne = json['street_one'];
    streetTwo = json['street_two'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    country = json['country'];
    type = json['type'];
    complete = json['complete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['street_one'] = this.streetOne;
    data['street_two'] = this.streetTwo;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['country'] = this.country;
    data['type'] = this.type;
    data['complete'] = this.complete;
    return data;
  }
}
