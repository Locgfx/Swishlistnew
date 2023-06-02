import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:swishlist/constants/urls.dart';
import 'package:http/http.dart' as http;
import 'package:swishlist/models/login_models.dart';
import '../../constants/globals/globals.dart';

Future login({
   required BuildContext context,
   required String email,
   required String password,
  // required String phone,
}) async {
  var headers = {
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  var request = http.Request('POST', Uri.parse('$baseUrl/api/login'));
  request.bodyFields = {
   if(email.contains("@")) 'email': email,
    if(!email.contains('@')) 'phone': email,
    'password': password,

  };
  print(request.bodyFields);
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if(response.statusCode == 200) {
    if(resp['status'] == true){
      return LoginResponse.fromJson(resp);
    } else {
      Globals().showErrorMessage(context, 'Please enter correct details.');
      return LoginResponse(
                  code: 1,
                  status: false,
                  message: 'message',
                  data: UserLogin(
                      id: 1,
                      name: 'name',
                      username: 'username',
                      email: 'email',
                      phone: 'phone',
                      photo: 'photo'),
                      token: 'token',);
    }
  } else {
      print(resp);
      print(response.statusCode);
      print(response.reasonPhrase);
      return false;
  }
}