

// class ScrappingModel {
//   String? title;
//   String? price;
//   String? currency;
//   String? image;
//
//   ScrappingModel({this.title, this.price, this.currency, this.image});
//
//   ScrappingModel.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     price = json['price'];
//     currency = json['currency'];
//     image = json['image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['title'] = this.title;
//     data['price'] = this.price;
//     data['currency'] = this.currency;
//     data['image'] = this.image;
//     return data;
//   }
// }

class LinkProductModel {
  bool? error;
  Data? data;

  LinkProductModel({this.error, this.data});

  LinkProductModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? title;
  dynamic price; // Change the type to dynamic

  String? currency;
  String? image;

  Data({this.title, this.price, this.currency, this.image});

  factory Data.fromJson(Map<String, dynamic> json) {
    var priceJson = json['price'];

    // Check if priceJson is a list or a single value
    if (priceJson is List) {
      // Handle list of prices
      return Data(
        title: json['title'],
        price: priceJson.map<String>((e) => e.toString()).toList(),
        currency: json['currency'],
        image: json['image'],
      );
    } else {
      // Handle single price
      return Data(
        title: json['title'],
        price: priceJson.toString(),
        currency: json['currency'],
        image: json['image'],
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['price'] = price;
    data['currency'] = currency;
    data['image'] = image;
    return data;
  }
}