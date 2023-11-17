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
    'Content-Type': 'application/json',
    'User-Agent': 'insomnia/8.2.0',
    'Accept': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('$newBaseUrl/api/login'));
  request.body = json.encode({
    "email": email,
    "password": password,
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if(response.statusCode == 200) {
    if(resp['error'] == false){
      return LoginResponse.fromJson(resp);
    } else {
      Globals().showErrorMessage(context, 'Please enter correct details.');
      return LoginResponse(
                  error: true,
                  message: 'message',
                  data: Data(
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