import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:swishlist/constants/urls.dart';



Future<dynamic> getAddressApi() async {

  var headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('GET', Uri.parse('$newBaseUrl/api/address'));

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



Future<dynamic> postAddressApi({
  required String houseNo,
  required String street,
  required String city,
  required String state,
  required String zip,
  required String country,

}) async{
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${ SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('POST', Uri.parse('$newBaseUrl/api/address/store'));
  request.body = json.encode({
    "street_one": houseNo,
    "street_two": street,
    "city": city,
    "state": state,
    "zip": zip,
    "country": country,
    "type": "home"
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



Future<dynamic> updateAddressApi({
  required String id,
  required String houseNo,
  required String street,
  required String city,
  required String state,
  required String zip,
  required String country,


}) async{
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${ SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('POST', Uri.parse('$newBaseUrl/api/address/update'));
  request.body = json.encode({
    "id": id,
    "street_one": houseNo,
    "street_two": street,
    "city": city,
    "state": state,
    "zip": zip,
    "country": country,
    "type": "home"
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