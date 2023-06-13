import 'dart:convert';
import 'package:http/http.dart' as http;


class Topic {
  final int id;
  final String name;
  final String questPath;

  Topic.fromJson(Map<String, dynamic> jsonData)
          :id = jsonData['id'],
          name = jsonData['name'],
          questPath = jsonData['question_path'];

}

class TopicApi {
  Future<List< Topic>> findAll() async {
    final response = await http.get(
      Uri.parse('https://dad-quiz-api.deno.dev/topics'),
    );
    List<dynamic> todoItems = jsonDecode(response.body);
    return List<Topic>.from(todoItems.map(
      (jsonData) => Topic.fromJson(jsonData),
    ));
  }
}

