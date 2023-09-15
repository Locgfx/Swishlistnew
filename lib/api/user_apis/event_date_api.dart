import 'dart:convert';
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:http/http.dart' as http;
import 'package:swishlist/constants/urls.dart';

Future<dynamic> getDateAndEventApi() async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('POST', Uri.parse('$baseUrl/api/user/eventDate'));
  request.bodyFields = {};
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

Future<dynamic> postDateAndEventApi({
    required String name,
    required String date,
    required String type,
    required String privacy,

}) async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest('POST',
      Uri.parse('$baseUrl/api/user/eventDate/store'));
  request.fields.addAll({
    'name': name,
    'date': date,
    'type': type,
    'privacy_status': privacy
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if(response.statusCode == 200) {
    return resp;
  } else {
    print(resp);
    print(response.statusCode);
    print(response.reasonPhrase);
    return resp;
  }
}


Future<dynamic> deleteEventAndDate({
  required String id,
}) async {
  var headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('POST', Uri.parse('$baseUrl/api/user/eventDate/delete'));
  request.bodyFields = {
    'id': id,
  };
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if(response.statusCode == 200) {
    return resp;
  } else {
    print(resp);
    print(response.statusCode);
    print(response.reasonPhrase);
    return resp;
  }

}


