import 'dart:convert';
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:http/http.dart' as http;
import 'package:swishlist/constants/urls.dart';
import 'package:swishlist/models/favourites_model.dart';



Future<dynamic> getFavouritesApi() async {
  var headers = {
    'Content-Type': 'multipart/form-data',
    'User-Agent': 'insomnia/8.2.0',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('GET', Uri.parse('$newBaseUrl/api/favourite'));

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




Future<dynamic> postFavouriteApi({
  required List car,
  required List bike,
  required List movies,
  required List shows,
  required List food,
  required List gadgets,
  required List superheroes,
  required List actors,
  required List actress,
  required List singer,
  required List player,
  required List cities,
  required List countries,
  required List restaurants,
  required List hotels,
  required String privacy,

}) async {

  var headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('POST', Uri.parse('$newBaseUrl/api/favourite/store'));



  request.body = json.encode({
    'cars': car,
    'bikes': bike,
    'movies': movies,
    'shows': shows,
    'foods': food,
    'gadgets': gadgets,
    'superheroes': superheroes,
    'actors': actors,
    'actresses': actress,
    'singers':singer ,
    'players': player,
    'cities': cities,
    'countries': countries,
    'restaurants': restaurants,
    'hotels': hotels,
    'privacy_status': privacy,
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  var resBody = jsonDecode(await response.stream.bytesToString());
  
  if(response.statusCode == 200 ) {
    print(resBody);
    return resBody;
  } else{
    print(resBody);
    print(response.statusCode);
    print(response.reasonPhrase);
    return resBody;
  }
}



// Future<dynamic> updateFavouriteApi({
//   required String car,
//   required String bike,
//   required String movies,
//   required String shows,
//   required String food,
//   required String gadgets,
//   required String superheroes,
//   required String actors,
//   required String actress,
//   required String singer,
//   required String player,
//   required String cities,
//   required String countries,
//   required String restaurants,
//   required String hotels,
//   required String privacy,
//   required String id
// })  async {
//   var headers = {
//     'Content-Type': 'application/x-www-form-urlencoded',
//     'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
//   };
//   var request = http.Request(
//       'POST', Uri.parse('$baseUrl/api/user/favourite/update'));
//   request.bodyFields = {
//     'cars': car,
//     'bikes': bike,
//     'movies': movies,
//     'shows': shows,
//     'foods': food,
//     'gadgets': gadgets,
//     'superheroes': superheroes,
//     'actors': actors,
//     'actresses': actress,
//     'singers': singer,
//     'players': player,
//     'cities': cities,
//     'countries': countries,
//     'restaurants':restaurants,
//     'hotels': hotels,
//     'privacy_status': privacy,
//     'id': id,
//   };
//   request.headers.addAll(headers);
//   http.StreamedResponse response = await request.send();
//   var resp = jsonDecode(await response.stream.bytesToString());
//   if(response.statusCode == 200) {
//     return resp;
//   } else{
//     print(resp);
//     print(response.reasonPhrase);
//     print(response.statusCode);
//     return resp;
//   }
// }
//
