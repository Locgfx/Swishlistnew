import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/urls.dart';
import '../../models/login_models.dart';

Future<dynamic> getAppleValidateToken({
  required String authorizedCode,
}) async {
  var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  var request = http.Request('POST', Uri.parse('$baseUrl/api/loginByTokenIos'));
  request.bodyFields = {
    'authorization_code': authorizedCode,
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
