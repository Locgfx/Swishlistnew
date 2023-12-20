import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:swishlist/constants/urls.dart';
import 'package:swishlist/models/new_models/room_create_model.dart';

Future<dynamic> getMessageApi({
  required int chatId,
  required String page,
}) async {
  var headers = {
    'Content-Type': 'multipart/form-data',
    'User-Agent': 'insomnia/8.2.0',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request(
      'GET',
       Uri.parse('$newBaseUrl/api/message?chat_id=$chatId&page=$page'));
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

Future<dynamic> sendMessageApi({
  required int chatId,
  required String message,
}) async {
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('POST', Uri.parse('$newBaseUrl/api/message/store'));
  request.body = json.encode({
    "chat_id": chatId,
    "message": message
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

Future<dynamic> sendProductMessageApi({

  required int chatId,
  required String message,
  required String productId,
}) async {
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('POST', Uri.parse('$newBaseUrl/api/message/store'));
  request.body = json.encode({
    "chat_id": chatId,
    "message": message,
    "product_id": productId
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

Future<dynamic> listMessageApi({
  required String specificUserid,
}) async {
  var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
  var request = http.MultipartRequest(
      'POST', Uri.parse('$baseUrl/api/user/message/specific/list'));
  request.fields.addAll({
    'specific_user_id': specificUserid,
  });
  request.headers.addAll(headers);
  print(request.fields);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print(resp);
    return resp;
  } else {
    print(response.reasonPhrase);
    print(response.statusCode);
    print(resp);
    return resp;
  }
}


Future<dynamic> postChatApi({
  required String friendId,
}) async {

  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };

  var request = http.Request('POST', Uri.parse('$newBaseUrl/api/chat/store'));
  request.body = json.encode({
    "user_id": friendId
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  var resBody = jsonDecode(await response.stream.bytesToString());

  if(resBody['error'] == false){
    return ChatRoomModel.fromJson(resBody);
  } else {

  print(response.statusCode);
  print(response.reasonPhrase);
  return false;
}

}