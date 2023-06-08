
class SearchModel {
  int? id;
  int? userId;
  String? name;
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
  String? updatedAt;
  String? deletedAt;
  SearchModel(
      {this.id,
        this.userId,
        this.name,
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
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        });

  SearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    gender = json['gender'].toString();
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
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'].toString();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
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
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}