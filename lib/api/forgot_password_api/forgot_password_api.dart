
import 'dart:convert';
import 'package:swishlist/constants/urls.dart';
import 'package:http/http.dart' as http;
Future forgotPasswordApi({
  required String email,
}) async{
  var headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };
  var request = http.Request('POST',
      Uri.parse('$newBaseUrl/api/forget-password'));
  request.body = json.encode({
    "email": email
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


Future forgotPasswordVerifyOtpApi({
  required String otp,
}) async{
  var headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('$newBaseUrl/api/verify-email'));
  request.body = json.encode({
    "code": otp,
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


Future resendCreateAccountOtpApi({
  required String email,
}) async{
  var headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };
  var request = http.Request('POST',
      Uri.parse('$newBaseUrl/api/resend-code'));
  request.body = json.encode({
    'email': email,
    'type': 'verify'
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