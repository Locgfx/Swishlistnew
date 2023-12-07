import 'dart:convert';
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:http/http.dart' as http;
import 'package:swishlist/constants/urls.dart';

Future<dynamic> getDateAndEventApi() async {
  // var headers = {
  //   'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  // };
  // var request = http.Request('POST', Uri.parse('$baseUrl/api/user/eventDate'));
  // request.bodyFields = {};
  // request.headers.addAll(headers);
  // http.StreamedResponse response = await request.send();
  // var resp = jsonDecode(await response.stream.bytesToString());
  // if(response.statusCode == 200) {
  //   print(resp);
  //   return resp;
  // } else {
  //   print(resp);
  //   print(response.statusCode);
  //   print(response.reasonPhrase);
  //   return resp;
  // }

  var headers = {
    'Content-Type': 'multipart/form-data',
    'User-Agent': 'insomnia/8.2.0',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('GET', Uri.parse('$newBaseUrl/api/event'));

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

Future<dynamic> postDateAndEventApi({
    required String name,
    required String date,

    required String time,
    required String privacy,

}) async {
  // var headers = {
  //   'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  // };
  // var request = http.MultipartRequest('POST',
  //     Uri.parse('$baseUrl/api/user/eventDate/store'));
  // request.fields.addAll({
  //   'name': name,
  //   'date': date,
  //   'type': type,
  //   'privacy_status': privacy
  // });
  // request.headers.addAll(headers);
  // http.StreamedResponse response = await request.send();
  // var resp = jsonDecode(await response.stream.bytesToString());
  // if(response.statusCode == 200) {
  //   return resp;
  // } else {
  //   print(resp);
  //   print(response.statusCode);
  //   print(response.reasonPhrase);
  //   return resp;
  // }

  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('POST', Uri.parse('$newBaseUrl/api/event/store'));
  request.body = json.encode({
    "name": name,
    "date": date,
    "time": time,
    "privacy": "private"
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


Future<dynamic> deleteEventAndDateApi({
  required String id,
}) async {
  // var headers = {
  //   'Content-Type': 'application/x-www-form-urlencoded',
  //   'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  // };
  // var request = http.Request('POST', Uri.parse('$baseUrl/api/user/eventDate/delete'));
  // request.bodyFields = {
  //   'id': id,
  // };
  // request.headers.addAll(headers);
  // http.StreamedResponse response = await request.send();
  // var resp = jsonDecode(await response.stream.bytesToString());
  // if(response.statusCode == 200) {
  //   return resp;
  // } else {
  //   print(resp);
  //   print(response.statusCode);
  //   print(response.reasonPhrase);
  //   return resp;
  // }

  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('POST', Uri.parse('$newBaseUrl/api/event/delete'));
  request.body = json.encode({
    "id": id
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


