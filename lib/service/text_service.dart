import 'dart:convert';
import '../model/info_model.dart';
import 'package:http/http.dart';

class TextService {
  List<Info> parseInfo(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Info>((json) => Info.fromJson(json)).toList();
  }

  Future<List<Info>> getInfo(int start) async {
    final Response response = await get(Uri.parse(
        'https://jsonplaceholder.typicode.com/posts?_start=$start&_limit=10'
        ));
    if (response.statusCode == 200) {
      return (parseInfo(response.body));
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
