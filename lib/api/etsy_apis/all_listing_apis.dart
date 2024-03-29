import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:swishlist/constants/urls.dart';

Future<dynamic> allEtsyListingApi({
  required String page,
}) async {
  var headers = {
    'Content-Type': 'application/json',
    'x-api-key': 'oqcujtilmdun1lcgvlp59otk',
    // 'Cookie': 'fve=1685077796.0; uaid=f2Zq16_qS6ihIWxrR5qKlfw57oNjZACClAJ7KRhdrVSamJmiZKVkGp7lnV7gEpId7uHv75eRnBrobJhmrKtb6JXioVTLAAA.; user_prefs=Crrq9ofhr2gKykE6JQV6Zy5Y2X9jZACClAJ7biitEq3k6RekpJNXmpOjo5Sap-vupKQDFIKKGEEoXEQsAwA.'
  };
  var request = http.Request(
      'GET',
      Uri.parse(
          '$etsyUrl/v3/application/listings/active?limit=25&offset=$page&shop_location=United States'));
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print(resp);
    return resp;
  } else {
    // print(resp);
    print(response.statusCode);
    print(response.reasonPhrase);
    return resp;
  }
}

Future<dynamic> allEtsyListingImagesApi({
  required String listingId,
}) async {
  var headers = {
    'Content-Type': 'application/json',
    'x-api-key': 'oqcujtilmdun1lcgvlp59otk',
    // 'Cookie': 'fve=1685077796.0; uaid=f2Zq16_qS6ihIWxrR5qKlfw57oNjZACClAJ7KRhdrVSamJmiZKVkGp7lnV7gEpId7uHv75eRnBrobJhmrKtb6JXioVTLAAA.; user_prefs=Crrq9ofhr2gKykE6JQV6Zy5Y2X9jZACClAJ7biitEq3k6RekpJNXmpOjo5Sap-vupKQDFIKKGEEoXEQsAwA.'
  };
  var request = http.Request(
      'GET', Uri.parse('$etsyUrl/v3/application/listings/$listingId/images'));
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    // print(resp);
    return resp;
  } else {
    print(response.statusCode);
    print(response.reasonPhrase);
    return resp;
  }
}

Future<dynamic> searchEtsyProductApi({
  required String search,
  required String page,
}) async {
  var headers = {
    'Content-Type': 'application/json',
    'x-api-key': 'oqcujtilmdun1lcgvlp59otk',
    // 'Cookie': 'fve=1685077796.0; uaid=f2Zq16_qS6ihIWxrR5qKlfw57oNjZACClAJ7KRhdrVSamJmiZKVkGp7lnV7gEpId7uHv75eRnBrobJhmrKtb6JXioVTLAAA.; user_prefs=Crrq9ofhr2gKykE6JQV6Zy5Y2X9jZACClAJ7biitEq3k6RekpJNXmpOjo5Sap-vupKQDFIKKGEEoXEQsAwA.'
  };
  var request = http.Request(
      'GET',
      Uri.parse(
          '$etsyUrl/v3/application/listings/active?limit=25&offset=$page&shop_location=United States&keywords=$search'));
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    // print(resp);
    return resp;
  } else {
    print(resp);
    print(response.statusCode);
    print(response.reasonPhrase);
    return resp;
  }
}

Future<dynamic> getSingleListing({
  required String listingId,
}) async {
  var headers = {
    'Content-Type': 'application/json',
    'x-api-key': 'oqcujtilmdun1lcgvlp59otk',
    // 'Cookie': 'fve=1685077796.0; uaid=f2Zq16_qS6ihIWxrR5qKlfw57oNjZACClAJ7KRhdrVSamJmiZKVkGp7lnV7gEpId7uHv75eRnBrobJhmrKtb6JXioVTLAAA.; user_prefs=Crrq9ofhr2gKykE6JQV6Zy5Y2X9jZACClAJ7biitEq3k6RekpJNXmpOjo5Sap-vupKQDFIKKGEEoXEQsAwA.'
  };
  var request = http.Request(
      'GET', Uri.parse('$baseUrl/v3/application/listings/$listingId'));
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
