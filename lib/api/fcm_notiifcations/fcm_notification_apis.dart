import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/globals/shared_prefs.dart';
import '../../constants/urls.dart';

Future<dynamic> fcmNotificationApi() async {
  var headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request =
      http.Request('GET', Uri.parse('$baseUrl/api/user/fcm/notification'));
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

Future<dynamic> fcmNotificationDeleteApi({
  required String id,
}) async {
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/x-www-form-urlencoded',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request(
      'POST', Uri.parse('$baseUrl/api/user/fcm/notification/delete'));
  request.bodyFields = {
    'id': id,
  };
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
