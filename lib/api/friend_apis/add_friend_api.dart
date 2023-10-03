import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:swishlist/constants/urls.dart';

import '../../constants/globals/shared_prefs.dart';

Future addFriendByMailPhoneApi({
  required String phoneEmail,
}) async {
  var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
  var request = http.MultipartRequest(
      'POST', Uri.parse('${baseUrl}/api/user/friend/store2'));
  request.fields.addAll({'phone_email': phoneEmail, 'status': 'requested'});
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
