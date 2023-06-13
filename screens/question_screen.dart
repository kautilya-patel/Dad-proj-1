import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/question_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/providers.dart';



class QuestionScreen extends ConsumerWidget {
  const QuestionScreen({super.key});

  _updateQues(WidgetRef ref, String path) async {
    Question j = await QuestionApi().findRandQ(path);
    ref.watch(questionProvider.notifier).update((state) => j);
  }
  _postAns(WidgetRef ref, String path, dynamic ans ) async {
    final c = await QuestionApi().isCorrect(path, ans);
    ref.watch(correctProvider.notifier).update((state) => c);
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Question w = ref.watch(questionProvider);
    final correct = ref.watch(correctProvider);
    final options = w.options.map(((e) => 
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    onPressed:() => {
                      _postAns(ref, w.answerPostPath, e)
                      }, 
                      child: Text("$e", style: const TextStyle(fontSize: 18)))) )).toList();
    final d = w.answerPostPath.split('/');
    final path = d.take(4).reduce((value, element) => "$value/$element",);

    return Scaffold( appBar: AppBar( title:  const Text("Quiz application"),
      actions: [ElevatedButton(
                  onPressed: ()=> context.go('/stats'),  
                  child: const Text("Stats page")),
                ElevatedButton(
                  onPressed: ()=> context.go('/'), 
                  child: const Text("Topics page"))],
    ),
    body: Center ( child : Column (children: [
      w.imageUrl != "" ? 
        Column(children: [
              Image.network(w.imageUrl), 
              Padding(
                padding: const EdgeInsets.all(10), 
                child: Text(w.question, style: const TextStyle(fontSize: 25))) 
              ],) 
              :Padding(
                padding: const EdgeInsets.all(10), 
                child: Text(w.question, style: const TextStyle(fontSize: 25))),
      Column(children: options),
      correct ?  Padding(padding: const EdgeInsets.all(20), child: ElevatedButton(onPressed:()=> {
          _updateQues(ref, path),
          ref.watch(correctProvider.notifier).update((state) => false),
          ref.watch(answerProvider.notifier).addQuest(d.elementAt(2)),
        }, 
        style: ElevatedButton.styleFrom( backgroundColor: Colors.green),
        child: const Text('next')))
        : const Padding(padding: EdgeInsets.all(20), child: Text('Select answer')),
    ]),
    ));
  }
}