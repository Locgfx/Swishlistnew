class EtsyListingIdModel {
  int? listingId;
  int? userId;
  int? shopId;
  String? title;
  String? description;
  String? state;
  int? shopSectionId;
  String? url;
  List<String>? tags;
  int? shippingProfileId;
  int? returnPolicyId;
  int? processingMin;
  int? processingMax;
  String? whoMade;
  String? whenMade;
  String? language;
  Price? price;
  int? views;
  List<Images>? images;

  EtsyListingIdModel(
      {this.listingId,
        this.userId,
        this.shopId,
        this.title,
        this.description,
        this.state,
        this.shopSectionId,
        this.url,
        this.tags,
        this.shippingProfileId,
        this.returnPolicyId,
        this.processingMin,
        this.processingMax,
        this.whoMade,
        this.whenMade,
        this.language,
        this.price,
        this.views,
        this.images});

  EtsyListingIdModel.fromJson(Map<String, dynamic> json) {
    listingId = json['listing_id'];
    userId = json['user_id'];
    shopId = json['shop_id'];
    title = json['title'];
    description = json['description'];
    state = json['state'];
    shopSectionId = json['shop_section_id'];
    url = json['url'];
    tags = json['tags'].cast<String>();
    shippingProfileId = json['shipping_profile_id'];
    returnPolicyId = json['return_policy_id'];
    processingMin = json['processing_min'];
    processingMax = json['processing_max'];
    whoMade = json['who_made'];
    whenMade = json['when_made'];
    language = json['language'];
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
    views = json['views'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['listing_id'] = this.listingId;
    data['user_id'] = this.userId;
    data['shop_id'] = this.shopId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['state'] = this.state;
    data['shop_section_id'] = this.shopSectionId;
    data['url'] = this.url;
    data['tags'] = this.tags;
    data['shipping_profile_id'] = this.shippingProfileId;
    data['return_policy_id'] = this.returnPolicyId;
    data['processing_min'] = this.processingMin;
    data['processing_max'] = this.processingMax;
    data['who_made'] = this.whoMade;
    data['when_made'] = this.whenMade;
    data['language'] = this.language;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    data['views'] = this.views;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
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

class Images {
  int? listingId;
  int? listingImageId;
  String? hexCode;
  int? red;
  int? green;
  int? blue;
  int? hue;
  int? saturation;
  int? brightness;
  bool? isBlackAndWhite;
  int? creationTsz;
  int? createdTimestamp;
  int? rank;
  String? url75x75;
  String? url170x135;
  String? url570xN;
  String? urlFullxfull;
  int? fullHeight;
  int? fullWidth;

  Images(
      {this.listingId,
        this.listingImageId,
        this.hexCode,
        this.red,
        this.green,
        this.blue,
        this.hue,
        this.saturation,
        this.brightness,
        this.isBlackAndWhite,
        this.creationTsz,
        this.createdTimestamp,
        this.rank,
        this.url75x75,
        this.url170x135,
        this.url570xN,
        this.urlFullxfull,
        this.fullHeight,
        this.fullWidth});

  Images.fromJson(Map<String, dynamic> json) {
    listingId = json['listing_id'];
    listingImageId = json['listing_image_id'];
    hexCode = json['hex_code'];
    red = json['red'];
    green = json['green'];
    blue = json['blue'];
    hue = json['hue'];
    saturation = json['saturation'];
    brightness = json['brightness'];
    isBlackAndWhite = json['is_black_and_white'];
    creationTsz = json['creation_tsz'];
    createdTimestamp = json['created_timestamp'];
    rank = json['rank'];
    url75x75 = json['url_75x75'];
    url170x135 = json['url_170x135'];
    url570xN = json['url_570xN'];
    urlFullxfull = json['url_fullxfull'];
    fullHeight = json['full_height'];
    fullWidth = json['full_width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['listing_id'] = this.listingId;
    data['listing_image_id'] = this.listingImageId;
    data['hex_code'] = this.hexCode;
    data['red'] = this.red;
    data['green'] = this.green;
    data['blue'] = this.blue;
    data['hue'] = this.hue;
    data['saturation'] = this.saturation;
    data['brightness'] = this.brightness;
    data['is_black_and_white'] = this.isBlackAndWhite;
    data['creation_tsz'] = this.creationTsz;
    data['created_timestamp'] = this.createdTimestamp;
    data['rank'] = this.rank;
    data['url_75x75'] = this.url75x75;
    data['url_170x135'] = this.url170x135;
    data['url_570xN'] = this.url570xN;
    data['url_fullxfull'] = this.urlFullxfull;
    data['full_height'] = this.fullHeight;
    data['full_width'] = this.fullWidth;
    return data;
  }
}