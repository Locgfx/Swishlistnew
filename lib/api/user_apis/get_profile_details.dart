// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:swishlist/constants/globals/shared_prefs.dart';
// import 'package:swishlist/constants/urls.dart';
//
// Future<dynamic> getProfileDetails() async {
//   var headers = {
//     'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
//   };
//   var request = http.Request('POST', Uri.parse('$baseUrl/api/user/profile'));
//   request.bodyFields = {};
//   request.headers.addAll(headers);
//   print(headers);
//   print(request.bodyFields);
//   http.StreamedResponse response = await request.send();
//   var resp = jsonDecode(await response.stream.bytesToString());
//   if(response.statusCode == 200) {
//     return resp;
//   } else {
//     print(resp);
//     print(response.statusCode);
//     print(response.reasonPhrase);
//     return resp;
//   }
//
// }