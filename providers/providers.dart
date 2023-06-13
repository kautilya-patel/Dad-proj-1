import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/topic_service.dart';
import '../services/question_service.dart';

class TopicNotifier extends StateNotifier<List<Topic>> {
  final topicApi = TopicApi();
  TopicNotifier() : super([]);

  _initialize() async {
    state = await topicApi.findAll();
  }
}

final topicProvider = StateNotifierProvider<TopicNotifier, List<Topic>>((ref) {
  final tn = TopicNotifier();
  tn._initialize();
  return tn;
});

class AnswerNotifier extends StateNotifier<List<String>> {
  final SharedPreferences prefs;
  final topicApi = TopicApi();
  AnswerNotifier(this.prefs) : super([]);

  _initialize() async {
    if (!prefs.containsKey("ans")) {
      return;
    }
    state = prefs.getStringList("ans")!;
  }
  addQuest(String id) async {
    state = [...state, id.toString()];
    prefs.setStringList("ans", state);
  }
}

final answerProvider = StateNotifierProvider<AnswerNotifier, List<String>>((ref) {
  final tn = AnswerNotifier(ref.watch(sharedPreferencesProvider));
  tn._initialize();
  return tn;
});
final questionProvider = StateProvider<Question>((ref) => Question(0,"",[],""));
final correctProvider = StateProvider<bool>((ref) => false);
final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());
