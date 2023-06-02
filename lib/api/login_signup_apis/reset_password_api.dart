import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:swishlist/constants/urls.dart';

Future<dynamic> resetPassGenerateOtpApi({
  required String emailPhone,
}) async {
  var headers = {
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  var request = http.Request(
      'POST',
      Uri.parse('$baseUrl/api/reset/request'));
  request.bodyFields = {
    'email': emailPhone,
  };
  request.headers.addAll(headers);
  print(headers);
  print(request);
  print(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if(response.statusCode == 200) {
    return resp;
  } else {
    print(response.statusCode);
    print(response.reasonPhrase);
    return resp;
  }
}


Future<dynamic> resetPassValidateOtpApi({
  required String emailPhone,
  required String otp,
  required String password,

}) async {
  var headers = {
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  var request = http.Request(
      'POST',
      Uri.parse('$baseUrl/api/reset/process'));
  request.bodyFields = {
    'email': emailPhone,
    'otp': otp,
    'password': password,
  };
  request.headers.addAll(headers);
  print(headers);
  print(request);
  print(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if(response.statusCode == 200) {
    return resp;
  } else {
    print(response.statusCode);
    print(response.reasonPhrase);
    return resp;
  }
}


