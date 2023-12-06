import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:swishlist/models/link_product_model.dart';
// import 'package:swishlist/models/link_product_model.dart';

Future<dynamic> productScrappingApi({
  required String productUrl,
}) async {
  var headers = {'Accept': 'application/json'};
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://swishlist.cosmeticplugs.com/api/scrap?url=$productUrl'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    if (resp['error'] == false) {
      print(resp);
      return LinkProductModel.fromJson(resp);
      // return productUrl.contains("amazon")
      //     ? LinkAmazonProductModel.fromJson(resp)
      //     : LinkProductModel.fromJson(resp);
    }
  } else {
    print(resp);
    print(response.statusCode);
    print(response.reasonPhrase);
    return false;
  }
}

Future<dynamic> scrappingAddProduct({
  required BuildContext context,
  required String type,
  required String name,
  required String link,
  required String price,
  required String purchaseDate,
  required String privacy,
  required String photo,
}) async {
  var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
  var request = http.MultipartRequest(
      'POST', Uri.parse('https://api.swishlist.com/api/user/product/store'));
  request.fields.addAll({
    'type': type,
    'name': name,
    'link': link,
    'price': price,
    'purchased_date': purchaseDate,
    'privacy_status': privacy
  });
  print(request.fields);
  request.files.add(await http.MultipartFile.fromPath('photo', photo));
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  print(resp);
  if (response.statusCode == 200) {
    return resp;
  } else {
    print(resp);
    print(response.reasonPhrase);
    print(response.statusCode);
    return resp;
  }
}
