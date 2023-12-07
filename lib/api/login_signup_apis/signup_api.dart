import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import '../../constants/urls.dart';
import '../../models/login_models.dart';

Future signUpApi({
  required String email,
    //required BuildContext context,
    //required String emailPhone,
   // required String password,

}) async{
  // var headers = {
  //   'Content-Type': 'application/x-www-form-urlencoded'
  // };
  // var request = http.Request('POST', Uri.parse('$baseUrl/api/signUp'));
  // request.bodyFields = {
  //   'email': emailPhone,
  // };
  // print(request.bodyFields);
  // request.headers.addAll(headers);
  // http.StreamedResponse response = await request.send();
  // var resp = jsonDecode(await response.stream.bytesToString());
  //   print(resp);
  //   if (response.statusCode == 200) {
  //     return resp;
  //   } else {
  //     print(resp);
  //     print(response.reasonPhrase);
  //     print(response.statusCode);
  //     return resp;
  //   }

  var headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('$newBaseUrl/api/signup'));
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

Future verifySignUpOtp({
  //  required BuildContext context,
    required String otp,
   // required String email,
    //required String password,

})  async {
  // var headers = {
  //   'Content-Type': 'application/x-www-form-urlencoded'
  // };
  // var request = http.Request('POST', Uri.parse('$baseUrl/api/validateOtp'));
  // request.bodyFields = {
  //   'email': email,
  //   'otp': otp,
  //   'password': password
  // };
  // print(request.bodyFields);
  // request.headers.addAll(headers);
  // print(headers);
  // http.StreamedResponse response = await request.send();
  // var resp = jsonDecode(await response.stream.bytesToString());
  // print(resp);
  // if(response.statusCode == 200) {
  //   if(resp['error'] == false){
  //     return LoginResponse.fromJson(resp);
  //   }
  //   else {
  //     Fluttertoast.showToast(msg: 'Please Enter Valid Otp');
  //     return LoginResponse(
  //       error: true,
  //       message: 'message',
  //       data: Data(
  //           id: 1,
  //           name: 'name',
  //           username: 'username',
  //           email: 'email',
  //           phone: 'phone',
  //           photo: 'photo'),
  //           token: 'token',
  //     );
  //   }
  // } else {
  //   print(resp);
  //   print(response.statusCode);
  //   print(response.reasonPhrase);
  //   return false;
  // }

  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('$newBaseUrl/api/verify-email'));
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

Future resendOtp({
   required BuildContext context,
   required String emailPhone,
}) async {
  var request = http.Request('POST', Uri.parse('$baseUrl/api/reset/request'));
  request.bodyFields = {
    'email': emailPhone
  };
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  print(resp);
  if (response.statusCode == 200) {
    return resp;
  } else {
    print(response.reasonPhrase);
    return resp;
  }
}


Future signupSetPassword({
  required String email,
  required String pass,
  required String confirmPass,
}) async{


  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('$newBaseUrl/api/set-password'));
  request.body = json.encode({
    "email": email,
    "password": pass,
    "password_confirmation": confirmPass
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