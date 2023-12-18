import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constants/globals/shared_prefs.dart';
import '../../constants/urls.dart';


// Future<dynamic> friendSizeApi({
//   required String id,
// })async{
//   var headers = {
//     'Accept': 'application/json',
//     'Content-Type': 'application/json',
//     'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
//   };
//   var request = http.Request('POST', Uri.parse('$newBaseUrl/api/user/details'));
//   request.body = json.encode({
//     "id": id
//   });
//   request.headers.addAll(headers);
//
//   http.StreamedResponse response = await request.send();
//   var resBody = jsonDecode(await response.stream.bytesToString());
//
//   if (response.statusCode == 200) {
//     // print(resBody);
//     return resBody;
//   }
//   else {
//     print(response.reasonPhrase);
//     print(response.statusCode);
//     print(resBody);
//     return resBody;
//   }
//
// }


Future<Map<String, dynamic>> friendSizeApi({
   required String id,
}) async {
  try {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
    };

    var response = await http.post(
      Uri.parse('$newBaseUrl/api/user/details'),
      headers: headers,
      body: json.encode({
        "id": id,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Error: ${response.reasonPhrase}');
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      return {'error': true, 'message': 'Error in API request'};
    }
  } catch (error) {
    print('Exception: $error');
    return {'error': true, 'message': 'Exception occurred'};
  }
}
