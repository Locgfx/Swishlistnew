import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/login_models.dart';

Future<dynamic> googleValidateToken({
  required String token,
}) async {
  var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  var request = http.Request(
      'POST', Uri.parse('https://api.swishlist.com/api/loginByToken'));
  request.bodyFields = {
    'token': token,
  };
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  print(resp);
  if (response.statusCode == 200) {
    return LoginResponse.fromJson(resp);
  } else {
    print(resp);
    print(response.reasonPhrase);
    print(response.statusCode);
    return resp;
  }
}
