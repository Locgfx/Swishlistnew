// class EtsyLoadMoreModel {
//   int? listingId;
//   int? userId;
//   int? shopId;
//   String? title;
//   String? description;
//   String? url;
//   String? language;
//   Price? price;
//   int? views;
//   String? image;
//
//   EtsyLoadMoreModel(
//       {this.listingId,
//         this.userId,
//         this.shopId,
//         this.title,
//         this.description,
//         this.url,
//         this.language,
//         this.price,
//         this.views,
//         this.image,
//       });
//
//   EtsyLoadMoreModel.fromJson(Map<String, dynamic> json) {
//     listingId = json['listing_id'];
//     userId = json['user_id'];
//     shopId = json['shop_id'];
//     title = json['title'];
//     description = json['description'];
//     url = json['url'];
//     language = json['language'];
//     price = json['price'] != null ? new Price.fromJson(json['price']) : null;
//     views = json['views'];
//     image = json['image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['listing_id'] = this.listingId;
//     data['user_id'] = this.userId;
//     data['shop_id'] = this.shopId;
//     data['title'] = this.title;
//     data['description'] = this.description;
//     data['url'] = this.url;
//     data['language'] = this.language;
//     if (this.price != null) {
//       data['price'] = this.price!.toJson();
//     }
//     data['views'] = this.views;
//     return data;
//   }
// }
//
// class Price {
//   int? amount;
//   int? divisor;
//   String? currencyCode;
//
//   Price({this.amount, this.divisor, this.currencyCode});
//
//   Price.fromJson(Map<String, dynamic> json) {
//     amount = json['amount'];
//     divisor = json['divisor'];
//     currencyCode = json['currency_code'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['amount'] = this.amount;
//     data['divisor'] = this.divisor;
//     data['currency_code'] = this.currencyCode;
//     return data;
//   }
// }


class EtsyLoadMoreModel {
  int? listingId;
  int? userId;
  int? shopId;
  String? title;
  String? description;
  String? url;
  List<String>? tags;
  Price? price;
  int? views;

  EtsyLoadMoreModel(
      {this.listingId,
        this.userId,
        this.shopId,
        this.title,
        this.description,
        this.url,
        this.tags,
        this.price,
        this.views});

  EtsyLoadMoreModel.fromJson(Map<String, dynamic> json) {
    listingId = json['listing_id'];
    userId = json['user_id'];
    shopId = json['shop_id'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    tags = json['tags'].cast<String>();
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
    views = json['views'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['listing_id'] = this.listingId;
    data['user_id'] = this.userId;
    data['shop_id'] = this.shopId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['tags'] = this.tags;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    data['views'] = this.views;
    return data;
  }
}

class Price {
  int? amount;
  int? divisor;
  String? currencyCode;

  Price({this.amount, this.divisor, this.currencyCode});

  Price.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    divisor = json['divisor'];
    currencyCode = json['currency_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['divisor'] = this.divisor;
    data['currency_code'] = this.currencyCode;
    return data;
  }
}