import 'dart:convert';
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:http/http.dart' as http;
import 'package:swishlist/constants/urls.dart';

Future <dynamic> getSizeAndWeightApi() async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('POST', Uri.parse('$baseUrl/api/user/sizeWeight'));
  request.bodyFields = {};
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if(response.statusCode == 200 ) {
    return resp;
  } else {
    print(resp);
    print(response.statusCode);
    print(response.reasonPhrase);
    return resp;
  }
}

Future<dynamic> updateSizeAndWeightApi({
  required String waist,
  required String shirt,
  required String shoes,
  required String bed,
  required String privacy,
  required String id,

}) async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/api/user/sizeWeight/update'));
  request.fields.addAll({
    'waist': waist,
    'shirt': shirt,
    'shoes': shoes,
    'bed': bed,
    'privacy_status': privacy,
    'id': id,
  });
  request.headers.addAll(headers);
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

Future<dynamic> postSizeAndWeightApi({
  required String waist,
  required String shirt,
  required String shoes,
  required String bed,
  required String privacy,
}) async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/api/user/sizeWeight/store'));
  request.fields.addAll({
    'waist': waist,
    'shirt': shirt,
    'shoes': shoes,
    'bed': bed,
    'privacy_status': privacy,
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    return resp;
  } else{
    print(resp);
    print(response.statusCode);
    print(response.reasonPhrase);
    return resp;
  }
}