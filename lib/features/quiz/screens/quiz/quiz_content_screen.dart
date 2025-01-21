import 'package:flutter/material.dart';
import 'package:nabeey/common/widgets/headers/quiz_header.dart';
import 'package:nabeey/features/quiz/screens/quiz_question_screen.dart';

import '../../models/quiz_model.dart';

class QuizContentScreen extends StatelessWidget {
  const QuizContentScreen({super.key, required this.quiz});

  final QuizModel quiz;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// Header
          ADQuizHeader(quiz: quiz),

          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => QuizQuestionScreen(quiz: quiz))),
              child: const Text("Boshlash"),
            ),
          ),
        ],
      ),
    );
  }
}
