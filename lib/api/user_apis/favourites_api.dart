import 'dart:convert';

import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:http/http.dart' as http;
import 'package:swishlist/constants/urls.dart';

Future<dynamic> getFavouritesApi() async {
  var headers = {
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('POST', Uri.parse('$baseUrl/api/user/favourite'));
  request.bodyFields = {};
  request.headers.addAll(headers);
  print(headers);
  print(request.bodyFields);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if(response.statusCode == 200){
    return resp;
  } else {
    print(resp);
    print(response.statusCode);
    print(response.reasonPhrase);
    return resp;
  }
}

Future<dynamic> postFavouriteApi({
  required String car,
  required String bike,
  required String movies,
  required String shows,
  required String food,
  required String gadgets,
  required String superheroes,
  required String actors,
  required String actress,
  required String singer,
  required String player,
  required String cities,
  required String countries,
  required String restaurants,
  required String hotels,
  required String privacy,

}) async {
  var headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request('POST',
      Uri.parse('$baseUrl/api/user/favourite/store'));
  request.bodyFields = {
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
  };
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if(response.statusCode == 200 ) {
    return resp;
  } else{
    print(resp);
    print(response.statusCode);
    print(response.reasonPhrase);
    return resp;
  }
}



Future<dynamic> updateFavouriteApi({
  required String car,
  required String bike,
  required String movies,
  required String shows,
  required String food,
  required String gadgets,
  required String superheroes,
  required String actors,
  required String actress,
  required String singer,
  required String player,
  required String cities,
  required String countries,
  required String restaurants,
  required String hotels,
  required String privacy,
  required String id
})  async {
  var headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Authorization': 'Bearer ${SharedPrefs().getLoginToken()}'
  };
  var request = http.Request(
      'POST', Uri.parse('$baseUrl/api/user/favourite/update'));
  request.bodyFields = {
    'cars': car,
    'bikes': bike,
    'movies': movies,
    'shows': shows,
    'foods': food,
    'gadgets': gadgets,
    'superheroes': superheroes,
    'actors': actors,
    'actresses': actress,
    'singers': singer,
    'players': player,
    'cities': cities,
    'countries': countries,
    'restaurants':restaurants,
    'hotels': hotels,
    'privacy_status': privacy,
    'id': id,
  };
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if(response.statusCode == 200) {
    return resp;
  } else{
    print(resp);
    print(response.reasonPhrase);
    print(response.statusCode);
    return resp;
  }
}

