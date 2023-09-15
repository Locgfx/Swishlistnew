import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:swishlist/constants/globals/shared_prefs.dart';
import '../../constants/urls.dart';

Future<dynamic> postNotificationApi({
  // required String userId,
  required String followRequest,
  required String shared,
  required String friendAddProduct,
  required String appUpdate,
}) async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/api/user/notification/store'));
  request.fields.addAll({
    'follow_request': followRequest,
    'shared_with_me': shared,
    'friend_add_product': friendAddProduct,
    'app_update': appUpdate,
  });
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

Future<dynamic> getNotificationApi() async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('POST', Uri.parse('$baseUrl/api/user/notification'));
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

Future<dynamic> updateNotificationApi({
  required String followRequest,
  required String sharedWithMe,
  required String friendAddProduct,
  required String appUpdate,
  required String id,

}) async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/api/user/notification/update'));
  request.fields.addAll({
    'follow_request': followRequest,
    'shared_with_me': sharedWithMe,
    'friend_add_product': friendAddProduct,
    'app_update': appUpdate,
    'id': id});
  request.headers.addAll(headers);
  http.StreamedResponse response =  await request.send();
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