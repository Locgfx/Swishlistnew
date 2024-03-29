class LinkAmazonProductAdd {
  bool? error;
  Data? data;

  LinkAmazonProductAdd({this.error, this.data});

  LinkAmazonProductAdd.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? title;
  List<String>? price;
  String? currency;
  String? image;

  Data({this.title, this.price, this.currency, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'].cast<String>();
    currency = json['currency'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['price'] = this.price;
    data['currency'] = this.currency;
    data['image'] = this.image;
    return data;
  }
}
