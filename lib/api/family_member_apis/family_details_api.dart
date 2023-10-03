import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:swishlist/constants/urls.dart';

import '../../constants/globals/shared_prefs.dart';

Future getFamilyDetailsApi({
  required String familyMemberId,
}) async {
  var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
  var request = http.MultipartRequest(
      'POST', Uri.parse('${baseUrl}/api/user/familyMember/detail'));
  request.fields.addAll({
    'family_member_user_id': familyMemberId,
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

Future<dynamic> familyMemberUserId({
  required String familyMemberUserId,
}) async {
  var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
  var request = http.MultipartRequest(
      'POST', Uri.parse('$baseUrl/api/user/familyMember/detail'));
  request.fields.addAll({
    'family_member_user_id': familyMemberUserId,
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
