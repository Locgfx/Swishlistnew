import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:swishlist/constants/urls.dart';

Future<dynamic> getFamilyMemberApi() async {
  var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
  var request =
      http.Request('POST', Uri.parse('$baseUrl/api/user/familyMember'));
  request.bodyFields = {};
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

Future<dynamic> postFamilyMemberApi({
  // required String userid,
  required String familyMemberMail,
}) async {
  var headers = {
  'Accept': 'application/json',
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('POST', Uri.parse('$newBaseUrl/api/member/request'));
  request.body = json.encode({
    "member_email": familyMemberMail,
  });
  // request.fields.addAll({
  //   'phone_email': familyMemberMail,
  //   'relation': relation.toLowerCase(),
  //   'status': status,
  //   'privacy_status': privacy,
  // });
  request.headers.addAll(headers);
  // print(request.fields);
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

Future<dynamic> updateFamilyMember({
  required String familyMemberId,
  required String relation,
  required String status,
  required String privacy,
  required String id,
}) async {
  var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
  var request = http.MultipartRequest(
      'Post', Uri.parse('$baseUrl/api/user/friend/update'));
  request.fields.addAll({
    'family_member_user_id': familyMemberId,
    'relation': relation,
    'status': status,
    'privacy_status': privacy,
    'id': id
  });
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

Future<dynamic> deleteFamilyMembers({
  required int id,
}) async {
 /* var headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request =
      http.Request('POST', Uri.parse('$baseUrl/api/user/familyMember/delete'));
  request.bodyFields = {'id': id};
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
  }*/

  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('POST', Uri.parse('$newBaseUrl/api/member/delete'));
  request.body = json.encode({
    "id": id
  });
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
