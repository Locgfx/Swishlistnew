import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swishlist/constants/globals/keys.dart';

import '../../constants/globals/shared_prefs.dart';

Future<dynamic> getNoticationByFCM() async {
  var prefs = await SharedPreferences.getInstance();
  String v = prefs.getString(SavedKeys().fcmToken) ?? "";
  // var token = prefs.getString(SavedKeys().cookie);
  var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
  var request = http.Request(
      'GET',
      Uri.parse('https://api.swishlist.com/api/getAuthUser?'
          'fcm_token=$v'));
  request.bodyFields = {};
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print('check fcm token api$resp');
    return resp;
  } else {
    print(resp);
    print(response.statusCode);
    print(response.reasonPhrase);
    return resp;
  }
}
