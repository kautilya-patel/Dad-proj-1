import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/providers.dart';
import '../services/question_service.dart';


class TopicScreen extends ConsumerWidget {
  const TopicScreen({super.key});
  _updateQues(WidgetRef ref, String path) async {
    Question j = await QuestionApi().findRandQ(path);
    ref.watch(questionProvider.notifier).update((state) => j);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final topics = ref.watch(topicProvider);
    final topList = List<Widget>.from(topics.map(
      (e) => Center(child: Container (padding: const EdgeInsets.all(5), child: ElevatedButton(
        onPressed: () => { _updateQues(ref, e.questPath), 
                          ref.watch(correctProvider.notifier).update((state) => false),
                          context.go(e.questPath) }, 
        child: Text(e.name, style: const TextStyle(fontSize: 18))
      ))
      )));

    final s = ref.watch(answerProvider);
    final r = topics.map(
      (e) => Answer(e.name, s.where((element) => (element == e.id.toString())).length,e.questPath))
      .toList();
    r.sort( ((a, b) => -a.count.compareTo(b.count)));
    return Scaffold(appBar: AppBar( title: const Text("Quiz application"), centerTitle: false,
      actions: [ ElevatedButton( 
        onPressed: () => context.go('/stats'),
        child: const Text("Stats page"),
      ),
      
       ]),
      body: topics.isNotEmpty ? 
      Column ( children: [
              Container(margin: const EdgeInsets.all(10),child: const Text("This application allows for answering questions from an API. By clicking on a topic below you will be shown a random question from that topic. There is also a general practice quiz which takes questions from topics with least number of questions answered.", style: TextStyle(fontSize: 20))),  
              ...topList, 
              Container(padding: const EdgeInsets.all(40), child: 
              ElevatedButton( 
                  onPressed: () => {
                    _updateQues(ref, r.last.questPath),
                    context.go('/genQuestions')
                    },
                  child: const Text("General Practice"),
                ))]) 
        : const Text("No topics available"),
    );
  }
}