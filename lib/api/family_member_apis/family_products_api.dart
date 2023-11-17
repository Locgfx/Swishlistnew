import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/globals/shared_prefs.dart';
import '../../constants/urls.dart';

Future<dynamic> getFamilyProductsApi({
  required String member_id,
}) async {
//   var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
//   var request = http.MultipartRequest(
//       'POST', Uri.parse('$baseUrl/api/user/familyMember/product'));
//   request.fields.addAll({
//     'family_member_user_id': familyId,
//   });
//   request.headers.addAll(headers);
//   http.StreamedResponse response = await request.send();
//   var resp = jsonDecode(await response.stream.bytesToString());
//   if (response.statusCode == 200) {
//     // print(resp);
//     return resp;
//   } else {
//     // print(resp);
//     print(response.statusCode);
//     print(response.reasonPhrase);
//     return resp;
//   }
// }
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('POST',
      Uri.parse('$newBaseUrl/api/member/products'));
  request.body = json.encode({
    "member_id": member_id
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
