import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/globals/shared_prefs.dart';

Future<dynamic> getNoticationByFCM({required String fcmToken}) async {
  var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
  var request = http.Request(
      'GET',
      Uri.parse('https://api.swishlist.com/api/getAuthUser?'
          'fcm_token=$fcmToken'));
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
