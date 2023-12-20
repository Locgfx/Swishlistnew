import 'dart:convert';
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:http/http.dart' as http;
import 'package:swishlist/constants/urls.dart';

Future<dynamic> getContactApi({
  required List contacts
}) async {
  // var headers = {
  //   'Content-Type': 'application/json',
  //   'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  // };
  // var request = http.Request('POST', Uri.parse('$baseUrl/api/search/contacts'));
  // request.body = json.encode({
  //   "contacts": contacts,
  // });
  // request.headers.addAll(headers);
  // print(headers);
  // print(request.body);
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
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('POST', Uri.parse('$newBaseUrl/api/search/contacts'));
  request.body = json.encode({
    "contacts": contacts

  });
  print(request.body);
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