import 'package:flutter/material.dart';
import 'package:nabeey/common/widgets/headers/quiz_header.dart';

import '../models/quiz_model.dart';

class QuizQuestionScreen extends StatelessWidget {
  const QuizQuestionScreen({super.key, required this.quiz});

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
              onPressed: () {},
              child: const Text("Keyingi"),
            ),
          ),
        ],
      ),
    );
  }
}
