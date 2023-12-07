import 'dart:convert';
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:http/http.dart' as http;
import 'package:swishlist/constants/urls.dart';

Future <dynamic> etsyStoreApi({
  required String type,
  required String name,
  required String link,
  required String price,
  required String purchaseDate,
  required String status,
  //required String photo,
  required String photoUrl,
  required String desc,
})async {
  // var headers = {
  //   'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  // };
  // var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/api/user/product/store'));
  // request.fields.addAll({
  //   'type': type,
  //   'name': name,
  //   'link': link,
  //   'price': price,
  //   'purchased_date': purchaseDate,
  //   'privacy_status': status,
  //   'photo_url': photoUrl,
  // });
  // if (photo != '') {
  //   request.files.add(await http.MultipartFile.fromPath('photo',photo));
  // }
  // request.headers.addAll(headers);
  // print(request.fields);
  // http.StreamedResponse response = await request.send();
  // var resp = jsonDecode(await response.stream.bytesToString());
  // if (response.statusCode == 200) {
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
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest('POST', Uri.parse('$newBaseUrl/api/product/store'));
  request.fields.addAll({
    'type': type,
    'name': name,
    'url': link,
    'price': price,
    'purchased_on': purchaseDate,
    'status': status,
    'description': desc,
    'photo_url': photoUrl
  });
  // if(photo != '') {
  //   request.files.add(await http.MultipartFile.fromPath('photo', photo));
  // }
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

