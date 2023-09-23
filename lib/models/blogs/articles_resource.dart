import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sustainify/models/blogs/models.dart';

Future<List<Articles>> fetchArticles() async {
  final response = await http.get(Uri.parse(
      'https://newsapi.org/v2/everything?q="waste management"&pageSize=50&apiKey=bb338facda384c838159a4d50bbdc0e1'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    final List<dynamic> articleList = jsonResponse['articles'];

    return articleList.map((article) => Articles.fromJson(article)).toList();
  } else { 
    throw Exception('Failed to load articles');
  }
}
