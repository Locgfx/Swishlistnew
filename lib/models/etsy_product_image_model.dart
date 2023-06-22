class EtsyImage {
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
  Null? altText;

  EtsyImage(
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
        this.fullWidth,
        this.altText});

  EtsyImage.fromJson(Map<String, dynamic> json) {
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
    altText = json['alt_text'];
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
    data['alt_text'] = this.altText;
    return data;
  }
}
