import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:swishlist/constants/urls.dart';

Future<dynamic> getProfileApi() async {
/*  var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
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
  }*/

  var headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest('POST', Uri.parse('$newBaseUrl/api/me'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  var resBody = jsonDecode(await response.stream.bytesToString());

  if (response.statusCode == 200) {
    print(resBody);
    return resBody;
  }
  else {
    print(response.reasonPhrase);
    print(response.statusCode);
   print(resBody);
    return resBody;
  }

}

Future<dynamic> updateProfileApi({
  required String name,
  required String userName,
  required String gender,
  required String dob,
  required String occupation,
  required String relationStatus,
  required String email,
  required String phone,
  required String alternateNo,
  required String privacyStatus,
  required String photo,

}) async {
  var headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest('POST', Uri.parse('$newBaseUrl/api/update-profile'));
  request.fields.addAll({
    'username': userName,
    'gender': gender,
    'date_of_birth': dob,
    'occupation': occupation,
    'marrital_status': relationStatus,
    'phone': phone,
    'additional_phone': alternateNo,
    'privacy': privacyStatus,
    'name': name,

  });
  request.files.add(await http.MultipartFile.fromPath('photo', photo));
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  var resBody = jsonDecode(await response.stream.bytesToString());

  if (response.statusCode == 200) {
    print(resBody);
    return resBody;
  }
  else {
    print(response.reasonPhrase);
    print(response.statusCode);
    print(resBody);
    return resBody;
  }
}

Future<dynamic> postProfileApi({
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
