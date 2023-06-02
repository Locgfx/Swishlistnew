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
  required String photo,
  required String photoUrl,

  // required String photoUrl,
})async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/api/user/product/store'));
  request.fields.addAll({
    'type': type,
    'name': name,
    'link': link,
    'price': price,
    'purchased_date': purchaseDate,
    'privacy_status': status,
    'photo_url': photoUrl,
  });
  if (photo != '') {
    request.files.add(await http.MultipartFile.fromPath('photo',photo));
  }
  request.headers.addAll(headers);
  print(request.fields);
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