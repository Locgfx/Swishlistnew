import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:swishlist/constants/urls.dart';

Future resetPassApi({
  required String email,
}) async {
  var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  var request = http.Request('POST', Uri.parse('$baseUrl/api/reset/request'));
  request.bodyFields = {
    'email': email,
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

Future resetPassOtpApi({
  required String email,
  required String otp,
}) async {
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  var request = http.Request('POST', Uri.parse('$baseUrl/api/reset/process'));
  request.bodyFields = {'email': email, 'otp': otp};
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

Future resetNewpApi({
  required String email,
  required String password,
}) async {
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  var request =
      http.Request('POST', Uri.parse('$baseUrl/api/reset/newpassword'));
  request.bodyFields = {'email': email, 'password': password};
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
