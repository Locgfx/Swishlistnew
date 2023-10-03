import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:swishlist/constants/urls.dart';

Future<dynamic> getProfileDetails() async {
  var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
  var request = http.Request('POST', Uri.parse('$baseUrl/api/user/profile'));
  request.bodyFields = {};
  request.headers.addAll(headers);
  print(headers);
  print(request.bodyFields);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print(resp);
    return resp;
  } else {
    print(resp);
    print(response.statusCode);
    print(response.reasonPhrase);
    return resp;
  }
}

Future<dynamic> updateProfile({
  required String name,
  required String gender,
  required String dob,
  required String occupation,
  required String relationStatus,
  required String email,
  required String phone,
  required String alternateNo,
  required String homeAddress,
  required String workAddress,
  required String privacyStatus,
  required String id,
  required String photo,
}) async {
  var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
  var request = http.MultipartRequest(
      'POST', Uri.parse('$baseUrl/api/user/profile/update'));
  request.fields.addAll({
    'name': name,
    'gender': gender,
    'dob': dob,
    'occupation': occupation,
    'relation_status': relationStatus,
    'email': email,
    'phone': phone,
    'alternate_phone': alternateNo,
    'home_address': homeAddress,
    'work_address': workAddress,
    'privacy_status': privacyStatus,
    'id': id,
  });
  if (photo != '') {
    request.files.add(
      await http.MultipartFile.fromPath('photo', photo),
    );
  }
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print(resp);
    return resp;
  } else {
    print(resp);
    print(response.statusCode);
    print(response.reasonPhrase);
    return resp;
  }
}

Future<dynamic> postProfile({
  required String name,
  required String gender,
  required String dob,
  required String occupation,
  required String relationStatus,
  required String email,
  required String phone,
  required String alternateNo,
  required String homeAddress,
  required String workAddress,
  required String privacyStatus,
  required String photo,
}) async {
  var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
  var request = http.MultipartRequest(
      'POST', Uri.parse('$baseUrl/api/user/profile/store'));
  request.fields.addAll({
    'name': name,
    'gender': gender,
    'dob': dob,
    'occupation': occupation,
    'relation_status': relationStatus,
    'email': email,
    'phone': phone,
    'alternate_phone': alternateNo,
    'home_address': homeAddress,
    'work_address': workAddress,
    'privacy_status': privacyStatus,
    // 'id': id,
  });
  if (photo != '') {
    request.files.add(await http.MultipartFile.fromPath('photo', photo));
  }
  request.headers.addAll(headers);
  print(request.fields);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  print(resp);
  if (response.statusCode == 200) {
    print(resp);
    return resp;
  } else {
    print(resp);
    print(response.statusCode);
    print(response.reasonPhrase);
    return resp;
  }
}
