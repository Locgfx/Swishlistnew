import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/urls.dart';
import '../../models/login_models.dart';

Future<dynamic> getAppleValidateTokenApi({
  required String authorizedCode,
}) async {
 /* var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
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
  }*/

  var headers = {
    'Content-Type': 'application/json',
    'User-Agent': 'insomnia/8.2.0',
    'Accept': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('$newBaseUrl/api/login/provider/apple'));
  request.body = json.encode({
    "authorization_code": authorizedCode
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  var resBody = jsonDecode(await response.stream.bytesToString());

  if (response.statusCode == 200) {
   // print(resBody);
    return LoginResponse.fromJson(resBody);
  }
  else {
    print(response.reasonPhrase);
    print(response.statusCode);
    print(resBody);
    return resBody;
  }

}
