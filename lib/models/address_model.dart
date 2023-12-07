class AddressModel {
  int? id;
  String? streetOne;
  String? streetTwo;
  String? city;
  String? state;
  String? zip;
  String? country;
  String? type;
  String? complete;

  AddressModel(
      {this.id,
        this.streetOne,
        this.streetTwo,
        this.city,
        this.state,
        this.zip,
        this.country,
        this.type,
        this.complete});

  AddressModel.fromJson(Map<String, dynamic> json) {
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
