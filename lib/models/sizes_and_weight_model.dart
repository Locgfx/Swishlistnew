// class SizesAndWeightModel {
//   bool? error;
//   String? message;
//   SizeData? data;
//
//   SizesAndWeightModel({this.error, this.message, this.data});
//
//   SizesAndWeightModel.fromJson(Map<String, dynamic> json) {
//     error = json['error'];
//     message = json['message'];
//     data = json['data'] != null ? new SizeData.fromJson(json['data']) : null;
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
// class SizeData {
//   int? id;
//   String? waist;
//   String? shirt;
//   String? shoe;
//   String? bed;
//   String? privacy;
//   String? complete;
//
//   SizeData(
//       {this.id,
//         this.waist,
//         this.shirt,
//         this.shoe,
//         this.bed,
//         this.privacy,
//         this.complete});
//
//   SizeData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     waist = json['waist'];
//     shirt = json['shirt'];
//     shoe = json['shoe'];
//     bed = json['bed'];
//     privacy = json['privacy'];
//     complete = json['complete'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['waist'] = this.waist;
//     data['shirt'] = this.shirt;
//     data['shoe'] = this.shoe;
//     data['bed'] = this.bed;
//     data['privacy'] = this.privacy;
//     data['complete'] = this.complete;
//     return data;
//   }
// }

//
// class SizesAndWeightModel {
//   int? id;
//   String? waist;
//   String? shirt;
//   String? shoe;
//   String? bed;
//   String? privacy;
//   String? complete;
//
//   SizesAndWeightModel(
//       {this.id,
//         this.waist,
//         this.shirt,
//         this.shoe,
//         this.bed,
//         this.privacy,
//         this.complete});
//
//   SizesAndWeightModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     waist = json['waist'];
//     shirt = json['shirt'];
//     shoe = json['shoe'];
//     bed = json['bed'];
//     privacy = json['privacy'];
//     complete = json['complete'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['waist'] = this.waist;
//     data['shirt'] = this.shirt;
//     data['shoe'] = this.shoe;
//     data['bed'] = this.bed;
//     data['privacy'] = this.privacy;
//     data['complete'] = this.complete;
//     return data;
//   }
// }



class SizesAndWeightModel {
  bool? error;
  String? message;
  Data? data;

  SizesAndWeightModel({this.error, this.message, this.data});

  SizesAndWeightModel.fromJson(Map<String, dynamic> json) {
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
  String? waist;
  String? shirt;
  String? shoe;
  String? bed;
  String? privacy;
  String? complete;

  Data(
      {this.id,
        this.waist,
        this.shirt,
        this.shoe,
        this.bed,
        this.privacy,
        this.complete});

  Data.fromJson(Map<String, dynamic> json) {
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