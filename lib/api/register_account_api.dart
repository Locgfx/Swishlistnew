
import 'dart:convert';

import 'package:swishlist/constants/urls.dart';

import '../constants/globals/shared_prefs.dart';
import 'package:http/http.dart' as http;
Future<dynamic> registerProfileApi({
  required String token,
  required String name,
  required String userName,
  required String email,
  required String phone,
  required String photo,

}) async {
  var headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  };

  print(headers);
  var request = http.MultipartRequest('POST', Uri.parse('$newBaseUrl/api/update-profile'));
  request.fields.addAll({
    'username': userName,
    'phone': phone,
    'name': name,

  });
  request.files.add(await http.MultipartFile.fromPath('photo', photo));
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