import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/login_models.dart';

Future<dynamic> getAppleValidateToken({
  required String authorizedCode,
  required String token,
  required String name,
  required String email,
}) async {
  var headers = {'Content-Type': 'text/plain'};
  var request =
      http.Request('GET', Uri.parse('https://api.swishlist.com/api/test'));
  request.bodyFields = {
    'authorization_code': authorizedCode,
    'token': token,
    'name': name,
    'email': email,
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
