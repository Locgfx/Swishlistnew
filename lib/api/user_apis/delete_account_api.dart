import 'dart:convert';

import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:http/http.dart' as http;
import 'package:swishlist/constants/urls.dart';

Future<dynamic> deleteAccountRequestApi()async {
  // var headers = {
  //   'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  // };
  // var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/api/account/deleteUser'));
  // request.headers.addAll(headers);
  // http.StreamedResponse response = await request.send();
  // var resp = jsonDecode(await response.stream.bytesToString());
  // if(response.statusCode == 200) {
  //   print(resp);
  //   return resp;
  // } else {
  //   print(resp);
  //   print(response.statusCode);
  //   print(response.reasonPhrase);
  //   return resp;
  // }

  var headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest('POST', Uri.parse('$newBaseUrl/api/account/delete-request'));

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


Future<dynamic> accountDeleteApi({
  required String otp,
}) async {
  // var headers = {
  //   'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  // };
  // var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/api/account/validateOtpDelete'));
  // request.fields.addAll({
  //   'otp': otp
  // });
  //
  // request.headers.addAll(headers);
  // http.StreamedResponse response = await request.send();
  // var resp = jsonDecode(await response.stream.bytesToString());
  // if(response.statusCode == 200) {
  //   print(resp);
  //   return resp;
  // } else {
  //   print(resp);
  //   print(response.statusCode);
  //   print(response.reasonPhrase);
  //   return resp;
  // }

  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('POST', Uri.parse('$newBaseUrl/api/account/delete'));
  request.body = json.encode({
    "code": otp
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