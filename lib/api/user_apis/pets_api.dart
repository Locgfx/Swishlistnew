import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constants/globals/shared_prefs.dart';
import '../../constants/urls.dart';

Future<dynamic> getPetsAPi() async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('POST', Uri.parse('$baseUrl/api/user/pet'));
  request.bodyFields = {};
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if(response.statusCode == 200) {
    print(resp);
    return resp;
  } else {
    print(response.statusCode);
    print(response.reasonPhrase);
    print(resp);
    return resp;
  }
}

Future<dynamic> postPetsApi({
  required String name,
  required String type,
  required String origin,
  required String privacyStatus,
  required String photo,

}) async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/api/user/pet/store'));
  request.fields.addAll({
    'name': name,
    'type': type,
    'origin': origin,
    'privacy_status':privacyStatus,
  });
  request.files.add(await http.MultipartFile.fromPath('photo', photo));
  request.headers.addAll(headers);
  print(request.fields);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if(response.statusCode == 200) {
    print(resp);
    return resp;
  } else {
    print(resp);
    print(response.statusCode);
    print(response.reasonPhrase);
    return resp;
  }
}


Future<dynamic> deletePetsApi({
  required String id,
}) async {
  var headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('POST', Uri.parse('$baseUrl/api/user/pet/delete'));
  request.bodyFields = {
    'id': id,
  };
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if(response.statusCode == 200) {
    print(resp);
    return resp;
  } else {
    print(resp);
    print(response.statusCode);
    print(response.reasonPhrase);
    return resp;
  }
}