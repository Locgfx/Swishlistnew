import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/globals/shared_prefs.dart';
import '../../constants/urls.dart';

Future<dynamic> fcmNotificationApi() async {
  var headers = {
    'Content-Type': 'multipart/form-data',
    'User-Agent': 'insomnia/8.2.0',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('GET', Uri.parse('$newBaseUrl/api/fcm/notification'));

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

Future<dynamic> fcmNotificationDeleteApi({
  required String id,
}) async {
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/x-www-form-urlencoded',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('POST', Uri.parse('$newBaseUrl/api/fcm/notification/delete'));
  request.body = json.encode({
    "ids": [id],
  });
  print(request.body);
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


Future<dynamic> fcmNotificationTokenApi({
  required String fcmToken,
}) async{

  var headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest('POST', Uri.parse('$newBaseUrl/api/update-profile'));
  request.fields.addAll({
    'fcm_token': fcmToken

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