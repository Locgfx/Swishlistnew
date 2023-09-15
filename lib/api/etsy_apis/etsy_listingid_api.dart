import 'dart:convert';
import 'package:http/http.dart' as http;
Future<dynamic> getListingByListingIds({
  required String listingId
}) async{
  var headers = {
    'Content-Type': 'application/json',
    'x-api-key': 'oqcujtilmdun1lcgvlp59otk',
    // 'Cookie': 'user_prefs=i3nUz76ld3aLhyPk8Nu-y3SQe9hjZACClN4Jn2B0dF5pTo4OeUQsAwA.'
  };
  var request = http.Request('GET', Uri.parse('https://openapi.etsy.com/v3/application/listings/batch?listing_ids=$listingId&includes=images'));
  request.headers.addAll(headers);
  // print(headers);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200){
    // print(resp);
    return resp;
  } else {
    print(resp);
    print(response.statusCode);
    print(response.reasonPhrase);
    return resp;
  }
}