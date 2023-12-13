import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:swishlist/constants/urls.dart';
import 'package:swishlist/models/scrapping_model.dart';

import '../../constants/globals/globals.dart';
import '../../models/ProductStoreMode.dart';

Future<dynamic> productStoreApi({
  required String type,
  required String name,
  required String link,
  required String price,
  required String purchaseDate,
  required String privacyStatus,
  required String photo,
}) async {
  var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
  var request = http.MultipartRequest(
      'POST', Uri.parse('$baseUrl/api/user/product/store'));
  request.fields.addAll({
    'type': type,
    'name': name,
    'link': link,
    'price': price,
    'purchased_date': purchaseDate,
    'privacy_status': privacyStatus,
  });
  request.files.add(await http.MultipartFile.fromPath('photo', photo));
  request.headers.addAll(headers);
  print(headers);
  print('"checking"${request.fields}');
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print(resp);
    return ProductStoreModel.fromJson(resp);
    // return resp;
  } else {
    print(resp);
    print(response.statusCode);
    print(response.reasonPhrase);
    return ProductStoreModel.fromJson(resp);
  }
}

/*Future<dynamic> getProductsApi() async {
  var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
  var request = http.Request('POST', Uri.parse('$baseUrl/api/user/product'));
  request.bodyFields = {};
  request.headers.addAll(headers);
  print(headers);
  print(request.bodyFields);
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
}*/

Future<dynamic> getProductsApi() async {

  var headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('GET', Uri.parse('$newBaseUrl/api/product'));

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

Future<dynamic> deleteProductsApi({
  required String id,
}) async {
//   var headers = {
//     'Content-Type': 'application/x-www-form-urlencoded',
//     'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
//   };
//   var request =
//       http.Request('POST', Uri.parse('$baseUrl/api/user/product/delete'));
//   request.bodyFields = {
//     'id': id,
//   };
//   request.headers.addAll(headers);
//   http.StreamedResponse response = await request.send();
//   var resp = jsonDecode(await response.stream.bytesToString());
//   if (response.statusCode == 200) {
//     print(resp);
//     return resp;
//   } else {
//     print(resp);
//     print(response.reasonPhrase);
//     print(response.statusCode);
//   }
// }
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request(
      'POST', Uri.parse('$newBaseUrl/api/product/delete'));
  request.body = json.encode({
    "id": id
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




// Future<dynamic> updateProducts({
//   required String type,
//   required String name,
//   required String link,
//   required String price,
//   required String purchaseDate,
//   required String privacyStatus,
//   required String photo,
//   required String id,
//   required String photoUrl,
// }) async {
//   var headers = {'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'};
//   var request = http.MultipartRequest(
//       'POST', Uri.parse('$baseUrl/api/user/product/update'));
//   request.fields.addAll({
//     'type': type,
//     'name': name,
//     'link': link,
//     'price': price,
//     'purchased_date': purchaseDate,
//     'privacy_status': privacyStatus,
//     'id': id,
//     'photo_url': photoUrl,
//   });
//   if (photo != '') {
//     request.files.add(await http.MultipartFile.fromPath('photo', photo));
//   }
//   // request.files.add(await http.MultipartFile.fromPath('photo', photo));
//   request.headers.addAll(headers);
//   http.StreamedResponse response = await request.send();
//   var resp = jsonDecode(await response.stream.bytesToString());
//   if (response.statusCode == 200) {
//     print(resp);
//     return resp;
//   } else {
//     print(resp);
//     print(response.reasonPhrase);
//     print(response.statusCode);
//   }
// }


Future<dynamic> updateProducts({
  required String name,
  required String id,
  required String type,
  required String url,
  required String date,
  required String price,
  required String photo,
}) async {


  var headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest('POST', Uri.parse('$newBaseUrl/api/product/update'));
  request.fields.addAll({
    // 'name': name,
    // 'id': id
    'type': type,
    'name': name,
    'url': url,
    'price': price,
    'purchased_on': date,
    'id': id,
  });
  if (photo != '') {
    request.files.add(await http.MultipartFile.fromPath('photo', photo));
  }

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

Future<dynamic> updateShareProducts({
  required String name,
  required String id,

}) async {


  var headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest('POST', Uri.parse('$newBaseUrl/api/product/update'));
  request.fields.addAll({
    // 'name': name,
    // 'id': id

    'name': name,

    'id': id,
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

Future<dynamic> scrappingProduct({
  required String url,
}) async {

  var headers = {
    'Accept': 'application/json'
  };
  var request = http.Request('GET', Uri.parse('$newBaseUrl/api/scrap?url=$url'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  var resBody = jsonDecode(await response.stream.bytesToString());

  if (response.statusCode == 200) {
    if(resBody['error'] == false){
      print(resBody);
      return LinkProductModel.fromJson(resBody);
    }

  }
  else {
    print(response.reasonPhrase);
    print(response.statusCode);
    print(resBody);
    return resBody;
  }
}


Future<dynamic>  scrappingProductStore({
  required String type,
  required String name,
  required String url,
  required String price,
  required String purchasesOn,
  required String status,
  required String desc,
  required String photo_url,
} ) async{

// var headers = {
// 'Accept': 'application/json',
// 'Authorization': 'Bear${SharedPrefs().getLoginToken()}'
// };
// var request = http.MultipartRequest('POST', Uri.parse('$newBaseUrl/api/product/store'));
// request.fields.addAll({
// 'type': type,
// 'name': name,
// 'url': url,
// 'price': price,
// 'purchased_on': purchasesOn,
// 'status': 'friend',
// 'description': desc
//
// });
// request.files.add(await http.MultipartFile.fromPath('photo', photo));
// request.headers.addAll(headers);
//
// http.StreamedResponse response = await request.send();
// var resBody = jsonDecode(await response.stream.bytesToString());
//
// if (response.statusCode == 200) {
// print(resBody);
// return resBody;
// }
// else {
// print(response.reasonPhrase);
// print(response.statusCode);
// print(resBody);
// return resBody;
// }

  var headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.MultipartRequest('POST', Uri.parse('https://swishlist.cosmeticplugs.com/api/product/store'));
  request.fields.addAll({
    'type': type,
    'name': name,
    'url': url,
    'price': price,
    'purchased_on': purchasesOn,
    'status': status,
    'description': desc,

    'photo_url': photo_url
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
