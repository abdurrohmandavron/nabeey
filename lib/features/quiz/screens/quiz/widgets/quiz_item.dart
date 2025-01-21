import 'package:flutter/material.dart';
import 'package:nabeey/features/quiz/models/quiz_model.dart';
import 'package:nabeey/utils/constants/colors.dart';

import '../quiz_content_screen.dart';

class QuizItem extends StatelessWidget {
  const QuizItem({super.key, required this.quiz});

  final QuizModel quiz;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => QuizContentScreen(quiz: quiz))),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: ADColors.primary,
          // border: Border.all(color: ADColors.primary, width: 3),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(quiz.name, style: Theme.of(context).textTheme.headlineMedium!.apply(color: ADColors.white)),
              Text(quiz.questionCount.toString(), style: Theme.of(context).textTheme.headlineMedium!.apply(color: ADColors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
