import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:swishlist/constants/urls.dart';
import 'package:swishlist/models/login_models.dart';

Future updateProfile({
  required BuildContext context,
  required String name,
  required String userName,
  required String photo,
  required String email,
  required String phone,
}) async {
  var headers = {
    'Authorization': 'Bearer  ${SharedPrefs().getLoginToken()}'
    // 'Authorization': 'Bearer 1470|xUc35vKxhccn3cCAYYbp7tOKtbnspqJjZp6mGOpr'
  };
  var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/api/updateProfile'));
  request.fields.addAll({
    'name': name,
    'username': userName,
    'email': email,
    'phone': phone,
  });
  request.files.add(await http.MultipartFile.fromPath('photo', photo));
  request.headers.addAll(headers);
  print(request.fields);
  print(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  print(resp);
  if (response.statusCode == 200) {
    if (resp['status'] == true ) {
      print(resp);
      return LoginResponse.fromJson(resp);
    } else {
      Fluttertoast.showToast(msg: 'Please Enter Valid Otp');
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
            token: 'token',
      );
    }
  } else {
    print(resp);
    print(response.statusCode);
    print(response.reasonPhrase);
    return false;
  }
}


Future<dynamic> createAccountApi({
  required String name,
  required String userName,
  required String photo,
  required String email,
  required String phone,
})async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/api/updateProfile'));
  request.fields.addAll({
    'name': name,
    'username': userName,
    'email': email,
    'phone': phone,
  });
  request.files.add(await http.MultipartFile.fromPath('photo',photo));
  request.headers.addAll(headers);
  print(request.fields);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
if(response.statusCode == 200 ) {
  print(resp);
  return resp;
} else {
  print(response.statusCode);
  print(response.reasonPhrase);
  print(resp);
  return resp;
}
}