// class EtsyImageModel {
//   int? listingId;
//   int? listingImageId;
//   String? url75x75;
//   String? url170x135;
//   String? url570xN;
//   String? urlFullxfull;
//
//   EtsyImageModel(
//       {this.listingId,
//         this.listingImageId,
//         this.url75x75,
//         this.url170x135,
//         this.url570xN,
//         this.urlFullxfull});
//
//   EtsyImageModel.fromJson(Map<String, dynamic> json) {
//     listingId = json['listing_id'];
//     listingImageId = json['listing_image_id'];
//     url75x75 = json['url_75x75'];
//     url170x135 = json['url_170x135'];
//     url570xN = json['url_570xN'];
//     urlFullxfull = json['url_fullxfull'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['listing_id'] = this.listingId;
//     data['listing_image_id'] = this.listingImageId;
//     data['url_75x75'] = this.url75x75;
//     data['url_170x135'] = this.url170x135;
//     data['url_570xN'] = this.url570xN;
//     data['url_fullxfull'] = this.urlFullxfull;
//     return data;
//   }
// }

class EtsyImagesModel {
  int? count;
  List<Results>? results;

  EtsyImagesModel({this.count, this.results});

  EtsyImagesModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? listingId;
  int? listingImageId;
  String? url75x75;
  String? url170x135;
  String? url570xN;
  String? urlFullxfull;
  int? fullHeight;
  int? fullWidth;

  Results(
      {this.listingId,
        this.listingImageId,
        this.url75x75,
        this.url170x135,
        this.url570xN,
        this.urlFullxfull,
        this.fullHeight,
        this.fullWidth});

  Results.fromJson(Map<String, dynamic> json) {
    listingId = json['listing_id'];
    listingImageId = json['listing_image_id'];
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
    data['url_75x75'] = this.url75x75;
    data['url_170x135'] = this.url170x135;
    data['url_570xN'] = this.url570xN;
    data['url_fullxfull'] = this.urlFullxfull;
    data['full_height'] = this.fullHeight;
    data['full_width'] = this.fullWidth;
    return data;
  }
}