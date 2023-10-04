import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:swishlist/constants/urls.dart';

import '../../constants/globals/shared_prefs.dart';

Future sharedProductApi({
  required String productId,
  required String leadUserId,
}) async {
  var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
  var request = http.MultipartRequest(
      'POST', Uri.parse('$baseUrl/api/user/sharedProduct/store'));
  request.fields.addAll({
    'product_id': productId,
    'lead_user_id': leadUserId,
  });

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
