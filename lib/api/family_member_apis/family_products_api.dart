import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/globals/shared_prefs.dart';
import '../../constants/urls.dart';

Future<dynamic> getFamilyProductsApi({
  required String familyId,
}) async {
  var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
  var request = http.MultipartRequest(
      'POST', Uri.parse('$baseUrl/api/user/familyMember/product'));
  request.fields.addAll({
    'family_member_user_id': familyId,
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    // print(resp);
    return resp;
  } else {
    // print(resp);
    print(response.statusCode);
    print(response.reasonPhrase);
    return resp;
  }
}
