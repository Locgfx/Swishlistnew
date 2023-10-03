import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/globals/shared_prefs.dart';
import '../../constants/urls.dart';

Future<dynamic> familyMemberIndexApi() async {
  var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
  var request =
      http.Request('POST', Uri.parse('$baseUrl/api/user/familyMember/request'));
  request.bodyFields = {};
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

Future<dynamic> familyMemberUpdateApi({
  required String status,
  required String id,
}) async {
  var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
  var request = http.MultipartRequest(
      'POST', Uri.parse('$baseUrl/api/user/familyMember/request/update'));
  request.fields.addAll({
    'status': status,
    'id': id,
  });
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

Future<dynamic> familyMemberDeleteApi({
  required String id,
}) async {
  // var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
  var headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request =
      http.Request('POST', Uri.parse('$baseUrl/api/user/familyMember/delete'));
  request.bodyFields = {
    'id': id,
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

Future<dynamic> getAcceptMember() async {
  // var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
  var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
  var request =
      http.Request('POST', Uri.parse('$baseUrl/api/user/familyMember'));
  request.bodyFields = {};
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
