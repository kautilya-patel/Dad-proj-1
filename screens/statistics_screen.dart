import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/providers.dart';
import '../services/question_service.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final s = ref.watch(answerProvider);
    final tops = ref.watch(topicProvider);
    final r = tops.map(
      (e) => Answer(e.name, s.where((element) => (element == e.id.toString())).length,e.questPath))
      .toList();
    r.sort( ((a, b) => -a.count.compareTo(b.count)));
    final wigs = List<Widget>.from(r.map((e) => Text("${e.topic} : ${e.count}", style: const TextStyle(fontSize: 15))));

    return Scaffold(appBar: AppBar( title: const Text("Quiz application"), centerTitle: false,
      actions: [
      ElevatedButton(onPressed: ()=> context.go('/'), child: const Text("Topics page"))],
    ),
      body: Center(child:Column(children: [ 
                            Container(padding: const EdgeInsets.all(10),child: Text("Number of questions answered correctly: ${s.length}", style: const TextStyle(fontSize: 25),),) , 
                            Container(padding: const EdgeInsets.all(10), child: const Text("Distribution of questions answered per topic:", style: TextStyle(fontSize: 25)), ) ,
                            ...wigs,
                            ],) ) 
      );
  }
}