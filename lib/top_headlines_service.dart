import 'dart:convert';

import 'top_headlines_model.dart';
import 'package:http/http.dart' as http;

Future<TopHeadlines> getTopHeadlines(String countryCode, String apiKey) async {
  String url = "https://newsapi.org";
  String endpoint =
      "/v2/top-headlines?country=$countryCode&apiKey=$apiKey&pageSize=${30}";
  String uri = url + endpoint;
  http.Client client = new http.Client();
  try {
    var response = await client.get(
      uri,
    );
    final jsonResponse = jsonDecode(response.body);
    TopHeadlines topHeadlines = TopHeadlines.fromJson(jsonResponse);
    print(response.body);
    return topHeadlines;
  } on Exception catch (e) {
    print(e.toString());
    return null;
  }
}
