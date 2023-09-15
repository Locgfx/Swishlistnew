
class FriendDetailsModel {
  int? code;
  bool? status;
  String? message;
  Data? data;

  FriendDetailsModel({this.code, this.status, this.message, this.data});
  FriendDetailsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if(json['data'].runtimeType == List<dynamic> ) {
      print('v');
      data = Data.fromJson({});
    } else if(json['data'] == null) {
      print('kkk');
      data = Data.fromJson({});
    } else{
      print('mdkmc');
      data = Data.fromJson(json['data']);
    }
    // data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    // data = json['data'] == [] ? null : json['data'] != null   ? Data.fromJson(json['data']) : null;
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
  String? name;
  String? username;
  String? phone;
  String? email;
  String? photo;
  String? type;
  Profile? profile;
  SizeWeight? sizeWeight;
  Interest? interest;
  List<Favourite>? favourite;
  List<Pets>? pets;
  List<EventDate>? eventDate;
  List<Family>? family;

  Data({this.id,
        this.name,
        this.username,
        this.phone,
        this.email,
        this.photo,
        this.type,
        this.profile,
        this.sizeWeight,
        this.interest,
        this.favourite,
        this.pets,
        this.eventDate,
        this.family});
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'].toString();
    phone = json['phone'].toString();
    email = json['email'];
    photo = json['photo'].toString();
    type = json['type'];
    profile = json['profile'] != null
        ? new Profile.fromJson(json['profile']) :
          Profile(
            name: '',
            photo: '',
            gender: '',
            dob: '',
            occupation: '',
            relationStatus: '',
            email: '',
            phone:'',
            alternatePhone: '',
            homeAddress: '',
            workAddress: '',
            privacyStatus: '',
            createdAt: '',
          );
    sizeWeight = json['sizeWeight'] != null
        ? new SizeWeight.fromJson(json['sizeWeight'])
        : SizeWeight(waist: '',shirt: '',bed: '',shoes: '',);
    interest = json['interest'] != null
        ? new Interest.fromJson(json['interest'])
        : null;
    if (json['favourite'] != null) {
      favourite = <Favourite>[];
      json['favourite'].forEach((v) {
        favourite!.add(new Favourite.fromJson(v));
      });
    }
    if (json['pets'] != null) {
      pets = <Pets>[];
      json['pets'].forEach((v) {
        pets!.add(new Pets.fromJson(v));
      });
    }
    if (json['eventDate'] != null) {
      eventDate = <EventDate>[];
      json['eventDate'].forEach((v) {
        eventDate!.add(new EventDate.fromJson(v));
      });
    }
    if (json['family'] != null) {
      family = <Family>[];
      json['family'].forEach((v) {
        family!.add(new Family.fromJson(v));
      });
    }
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
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    if (this.sizeWeight != null) {
      data['sizeWeight'] = this.sizeWeight!.toJson();
    }
    if (this.interest != null) {
      data['interest'] = this.interest!.toJson();
    }
    if (this.favourite != null) {
      data['favourite'] = this.favourite!.map((v) => v.toJson()).toList();
    }
    if (this.pets != null) {
      data['pets'] = this.pets!.map((v) => v.toJson()).toList();
    }
    if (this.eventDate != null) {
      data['eventDate'] = this.eventDate!.map((v) => v.toJson()).toList();
    }
    if (this.family != null) {
      data['family'] = this.family!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Profile {
  int? id;
  int? userId;
  String? name;
  String? photo;
  String? gender;
  String? dob;
  String? occupation;
  String? relationStatus;
  String? email;
  String? phone;
  String? alternatePhone;
  String? homeAddress;
  String? workAddress;
  String? privacyStatus;
  String? createdAt;

  Profile(
      {this.id,
        this.userId,
        this.name,
        this.photo,
        this.gender,
        this.dob,
        this.occupation,
        this.relationStatus,
        this.email,
        this.phone,
        this.alternatePhone,
        this.homeAddress,
        this.workAddress,
        this.privacyStatus,
        this.createdAt});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    photo = json['photo'];
    gender = json['gender'];
    dob = json['dob'];
    occupation = json['occupation'];
    relationStatus = json['relation_status'];
    email = json['email'];
    phone = json['phone'];
    alternatePhone = json['alternate_phone'];
    homeAddress = json['home_address'];
    workAddress = json['work_address'];
    privacyStatus = json['privacy_status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['occupation'] = this.occupation;
    data['relation_status'] = this.relationStatus;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['alternate_phone'] = this.alternatePhone;
    data['home_address'] = this.homeAddress;
    data['work_address'] = this.workAddress;
    data['privacy_status'] = this.privacyStatus;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class SizeWeight {
  int? id;
  int? userId;
  String? waist;
  String? shirt;
  String? shoes;
  String? bed;
  String? privacyStatus;
  String? createdAt;

  SizeWeight(
      {this.id,
        this.userId,
        this.waist,
        this.shirt,
        this.shoes,
        this.bed,
        this.privacyStatus,
        this.createdAt});

  SizeWeight.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    waist = json['waist'];
    shirt = json['shirt'];
    shoes = json['shoes'];
    bed = json['bed'];
    privacyStatus = json['privacy_status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['waist'] = this.waist;
    data['shirt'] = this.shirt;
    data['shoes'] = this.shoes;
    data['bed'] = this.bed;
    data['privacy_status'] = this.privacyStatus;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Interest {
  int? id;
  int? userId;
  String? interest;
  String? privacyStatus;
  String? createdAt;

  Interest(
      {this.id,
        this.userId,
        this.interest,
        this.privacyStatus,
        this.createdAt});

  Interest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    interest = json['interest'];
    privacyStatus = json['privacy_status'].toString();
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['interest'] = this.interest;
    data['privacy_status'] = this.privacyStatus;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Favourite {
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
  String? createdAt;

  Favourite(
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
        this.createdAt});

  Favourite.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['created_at'];
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
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Pets {
  int? id;
  int? userId;
  String? name;
  String? type;
  String? origin;
  String? photo;
  String? privacyStatus;
  String? createdAt;

  Pets(
      {this.id,
        this.userId,
        this.name,
        this.type,
        this.origin,
        this.photo,
        this.privacyStatus,
        this.createdAt});

  Pets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    type = json['type'];
    origin = json['origin'];
    photo = json['photo'];
    privacyStatus = json['privacy_status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['origin'] = this.origin;
    data['photo'] = this.photo;
    data['privacy_status'] = this.privacyStatus;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class EventDate {
  int? id;
  int? userId;
  String? name;
  String? date;
  String? type;
  String? privacyStatus;
  String? createdAt;

  EventDate(
      {this.id,
        this.userId,
        this.name,
        this.date,
        this.type,
        this.privacyStatus,
        this.createdAt});

  EventDate.fromJson(Map<String, dynamic> json) {
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

class Family {
  int? id;
  int? userId;
  int? familyMemberUserId;
  String? relation;
  String? status;
  String? privacyStatus;
  String? createdAt;

  Family(
      {this.id,
        this.userId,
        this.familyMemberUserId,
        this.relation,
        this.status,
        this.privacyStatus,
        this.createdAt});

  Family.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    familyMemberUserId = json['family_member_user_id'];
    relation = json['relation'];
    status = json['status'];
    privacyStatus = json['privacy_status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['family_member_user_id'] = this.familyMemberUserId;
    data['relation'] = this.relation;
    data['status'] = this.status;
    data['privacy_status'] = this.privacyStatus;
    data['created_at'] = this.createdAt;
    return data;
  }
}