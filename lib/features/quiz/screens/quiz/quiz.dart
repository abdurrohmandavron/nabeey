import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/quiz_model.dart';
import '../../../explore/blocs/base/base_bloc.dart';
import '../../../explore/blocs/base/base_state.dart';
import '../../../../utils/helpers/check_bloc_state.dart';
import 'widgets/quiz_item.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// Quizzes
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: BlocBuilder<BaseBloc<QuizModel>, BaseState>(
                builder: (context, state) {
                  return CheckBlocState.checkState(context, state) ??
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: (state as ItemsLoaded).items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 24),
                        itemBuilder: (context, index) {
                          final quiz = state.items[index] as QuizModel;
                          return QuizItem(quiz: quiz);
                        },
                      );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
