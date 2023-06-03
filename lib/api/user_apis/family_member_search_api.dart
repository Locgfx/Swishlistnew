import 'dart:convert';

import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:http/http.dart' as http;
import 'package:swishlist/constants/urls.dart';

Future<dynamic> searchMemberApi({
  required String name,
})async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/api/search/user'));
  request.fields.addAll({
    'name': name,
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
