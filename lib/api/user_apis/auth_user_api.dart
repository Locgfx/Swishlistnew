import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:swishlist/constants/urls.dart';
import 'package:swishlist/models/login_models.dart';
// Future<dynamic> authTokenLoginApi({required String token}) async {
//   var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
//   var request =
//       http.Request('GET', Uri.parse('$baseUrl/api/getAuthUser?token=$token'));
//   request.bodyFields = {};
//   request.headers.addAll(headers);
//   http.StreamedResponse response = await request.send();
//   var resp = jsonDecode(await response.stream.bytesToString());
//   print('check resp${resp}');
//   if (response.statusCode == 200) {
//     print('check resp${resp}');
//     return LoginResponse.fromJson(resp);
//   } else {
//     // print(resp);
//     print(response.reasonPhrase);
//     print(response.statusCode);
//     return false;
//   }
// }
//
// Future<dynamic> fcmTokenApi({required String fcmToken}) async {
//   var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
//   var request = http.Request(
//       'GET', Uri.parse('$baseUrl/api/getAuthUser?fcm_token=$fcmToken'));
//   request.bodyFields = {};
//   request.headers.addAll(headers);
//   http.StreamedResponse response = await request.send();
//   var resp = jsonDecode(await response.stream.bytesToString());
//   print('check resp${resp}');
//   if (response.statusCode == 200) {
//     print('check resp${resp}');
//     return LoginResponse.fromJson(resp);
//   } else {
//     // print(resp);
//     print(response.reasonPhrase);
//     print(response.statusCode);
//     return false;
//   }
// }

Future<dynamic> authTokenLoginApi(
    {required String token, required String fcmToken}) async {
  var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
  var request = http.Request('GET',
      Uri.parse('$baseUrl/api/getAuthUser?fcm_token=$fcmToken&token=$token'));
  request.bodyFields = {};
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  print('check resp${resp}');
  if (response.statusCode == 200) {
    print('check resp${resp}');
    return LoginResponse.fromJson(resp);
  } else {
    // print(resp);
    print(response.reasonPhrase);
    print(response.statusCode);
    return false;
  }
}
