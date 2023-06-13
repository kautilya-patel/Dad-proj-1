import 'dart:convert';
import 'package:http/http.dart' as http;


class Question {
  final int id;
  final String question;
  final List<dynamic> options;
  final String answerPostPath;
  String imageUrl = "";

  Question.fromJson(Map<String, dynamic> jsonData)
          :id = jsonData['id'],
          question = jsonData['question'],
          options = jsonData['options'],
          answerPostPath = jsonData['answer_post_path'],
          imageUrl = (jsonData['image_url']) ?? "";
  Question (this.id,this.answerPostPath,this.options,this.question);
}

class Answer {
  final String topic;
  final String questPath;
  int count;

  Answer(this.topic, this.count, this.questPath);
}

class QuestionApi {
  Future<Question> findRandQ(String path) async {
    final response = await http.get(
      Uri.parse('https://dad-quiz-api.deno.dev$path'),
    );
    Question q = Question.fromJson(jsonDecode(response.body));
    return q;
  }

  Future<bool> isCorrect(String path, dynamic ans) async {
    final data = {"answer": ans};
    final res = await http.post(
      Uri.parse("https://dad-quiz-api.deno.dev$path"),
      body: jsonEncode(data),
    );
    return jsonDecode(res.body)["correct"];
  }

}

