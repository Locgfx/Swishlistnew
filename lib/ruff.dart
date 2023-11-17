class SizesAndWeight {
  int? id;
  String? waist;
  String? shirt;
  String? shoe;
  String? bed;
  String? privacy;
  String? complete;

  SizesAndWeight(
      {this.id,
        this.waist,
        this.shirt,
        this.shoe,
        this.bed,
        this.privacy,
        this.complete});

  SizesAndWeight.fromJson(Map<String, dynamic> json) {
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
