import 'package:go_router/go_router.dart';
import '../screens/topic_screen.dart';
import '../screens/question_screen.dart';
import '../screens/statistics_screen.dart';
import '../screens/generic_question_screen.dart';


final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const TopicScreen()),
    GoRoute(
        path: '/topics/:id/questions',
        builder: (context, state) =>
            const QuestionScreen()),
    GoRoute(
        path: '/stats',
        builder: (context, state) =>
            const StatsScreen()),
    GoRoute(
        path: '/genQuestions',
        builder: (context, state) =>
            const GenericQuestionScreen()),
  ],
);