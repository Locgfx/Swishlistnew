import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:http/http.dart' as http;
import 'package:swishlist/constants/urls.dart';
import 'package:swishlist/models/sizes_and_weight_model.dart';

Future <dynamic> getSizeAndWeightApi() async {
/*
  var headers = {
     'Content-Type': 'multipart/form-data',

     'Accept': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('GET', Uri.parse('$newBaseUrl/api/sizing'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  var resBody = jsonDecode(await response.stream.bytesToString());

  if (response.statusCode == 200) {
    // if(resBody['error'] == false){
    //   return SizesAndWeightModel.fromJson(resBody);
    print(resBody);
    // }
    return  SizesAndWeightModel.fromJson(resBody);
    // else{
    //
    //   return SizesAndWeightModel(
    //     error: true,
    //     message: 'message',
    //     data: SizeData(
    //       waist: '',
    //       shirt: '',
    //       shoe: '',
    //       bed: '',),
    //     );
    // }
    }
  else {
    print(response.reasonPhrase);
    print(response.statusCode);
    print(resBody);
    return resBody;
  }
*/

  var headers = {
    'Content-Type': 'multipart/form-data',
    'User-Agent': 'insomnia/8.2.0',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('GET', Uri.parse('$newBaseUrl/api/sizing'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  var resBody = jsonDecode(await response.stream.bytesToString());

  if (response.statusCode == 200) {
   // if(resBody['error'] == false){
      print(resBody);
      return resBody;
   // }

  }
  else {
    print(response.reasonPhrase);
    print(response.statusCode);
   print(resBody);
    return resBody;
  }
}

// Future<dynamic> updateSizeAndWeightApi({
//   required String waist,
//   required String shirt,
//   required String shoes,
//   required String bed,
//   required String privacy,
//   required String id,
//
// }) async {
//   var headers = {
//     'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
//   };
//   var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/api/user/sizeWeight/update'));
//   request.fields.addAll({
//     'waist': waist,
//     'shirt': shirt,
//     'shoes': shoes,
//     'bed': bed,
//     'privacy_status': privacy,
//     'id': id,
//   });
//   request.headers.addAll(headers);
//   http.StreamedResponse response = await request.send();
//   var resp = jsonDecode(await response.stream.bytesToString());
//   if(response.statusCode == 200) {
//     return resp;
//   } else {
//     print(resp);
//     print(response.statusCode);
//     print(response.reasonPhrase);
//     return resp;
//   }
// }

Future<dynamic> postSizeAndWeightApi({
  required String waist,
  required String shirt,
  required String shoes,
  required String bed,
  required String privacy,
}) async {

  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };


  var request = http.Request('POST', Uri.parse('$newBaseUrl/api/sizing/store'));

  request.body = json.encode({
    "waist": waist,
    "shirt": shirt,
    "shoe": shoes,
    "privacy": "private",
    "bed": bed,
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
    return false;
  }
}