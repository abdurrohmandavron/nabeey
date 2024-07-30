import 'package:flutter/material.dart';
import 'package:nabeey/common/widgets/appbar/appbar.dart';
class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return const Scaffold(
      appBar: ADAppBar(
        title: Text('Hello quiz'),
      ),
    );
  }
}
