import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:swishlist/constants/urls.dart';

import '../../models/activity1_model.dart';

Future<dynamic> getActivityApi() async {
  var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
  var request =
      http.MultipartRequest('POST', Uri.parse('$baseUrl/api/user/activities'));
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  print(headers);
  print(request.headers);
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

Future postActivityApi(
    {required String leadUserid, required String productId}) async {
  var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
  var request = http.MultipartRequest(
      'POST', Uri.parse('$baseUrl/api/user/activities/store'));
  request.fields.addAll({
    'lead_user_id': leadUserid,
    'product_id': productId,
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
    print(response.request);
    return resp;
  }
}

Future activity() async {
  var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
  var request =
      http.MultipartRequest('POST', Uri.parse('$baseUrl/api/user/activities'));
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var resBody = jsonDecode(await response.stream.bytesToString());

  if (response.statusCode == 200) {
    print(resBody);
    return ActivityModel.fromJson(resBody);
  } else {
    print(resBody);
    print(response.statusCode);
    print(response.reasonPhrase);
    return false;
  }
}
