import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:swishlist/constants/urls.dart';

import '../../models/login_models.dart';

Future<dynamic> authUserApi({required String fcmToken}) async {
  var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://api.swishlist.com/api/getAuthUser?fcm_token=$fcmToken'));
  request.bodyFields = {};
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  print(resp);
  if (response.statusCode == 200) {
    return LoginResponse.fromJson(resp);
  } else {
    // print(resp);
    print(response.reasonPhrase);
    print(response.statusCode);
    return resp;
  }
}

Future<dynamic> authTokenLoginApi(
    {required String token, required String fcmToken}) async {
  var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
  var request = http.Request('GET',
      Uri.parse('$baseUrl/api/getAuthUser?fcm_token=$fcmToken&token=$token'));
  request.bodyFields = {};
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  print(resp);
  if (response.statusCode == 200) {
    print(resp);
    return LoginResponse.fromJson(resp);
  } else {
    // print(resp);
    print(response.reasonPhrase);
    print(response.statusCode);
    return false;
  }
}
