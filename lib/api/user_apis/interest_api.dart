import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:swishlist/constants/urls.dart';

Future<dynamic> postInterestApi({
required String interest,

}) async{
  // var headers = {
  //   'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  // };
  // var request = http.MultipartRequest('POST',
  //     Uri.parse('$baseUrl/api/user/interest/store')
  // );
  // request.fields.addAll({
  //   'interest': interest,
  // });
  // request.headers.addAll(headers);
  // print(headers);
  // print(request.fields);
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
  var request = http.Request('POST', Uri.parse('$newBaseUrl/api/interest/store'));
  request.body = json.encode({
    "interests": [
      // "Toyota Camry",
      // "Honda Civic",
      // "Ford Mustang",
      // "Chevrolet Malibu",
      // "Nissan Altima"
      interest
    ],
    "privacy": "friend"
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

Future<dynamic> updateInterest({
  required String userid,
  required String interest,
  required String id,
}) async{
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest('POST',
      Uri.parse('$baseUrl/api/user/interest/update'));
  request.fields.addAll({
    'user_id': userid,
    'interest': interest,
    'id': id,
  });

  request.headers.addAll(headers);
  print(headers);
  print(request.fields);
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

Future<dynamic> getInterestApi() async {
  // var headers = {
  //   'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  // };
  // var request = http.Request('POST', Uri.parse('$baseUrl/api/user/interest'));
  // request.bodyFields = {};
  // request.headers.addAll(headers);
  // http.StreamedResponse response = await request.send();
  // var resp = jsonDecode(await response.stream.bytesToString());
  // if (response.statusCode == 200) {
  //   return resp;
  // } else {
  //   print(resp);
  //   print(response.statusCode);
  //   print(response.reasonPhrase);
  //   return resp;
  //
  // }


  var headers = {
    'Content-Type': 'multipart/form-data',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('GET', Uri.parse('$newBaseUrl/api/interest'));

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