import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:nabeey/utils/constants/colors.dart';
import 'package:nabeey/common/widgets/images/rounded_image.dart';

import '../../../features/quiz/models/quiz_model.dart';

class ADQuizHeader extends StatelessWidget {
  const ADQuizHeader({super.key, required this.quiz});

  final QuizModel quiz;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: RoundedImage(
        borderRadius: 20,
        fit: BoxFit.cover,
        applyImageRadius: true,
        width: double.infinity,
        height: double.infinity,
        imageUrl: "assets/images/quiz.png",
        padding: const EdgeInsets.all(20),
        gradient: const LinearGradient(
          begin: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(0, 0, 0, 0.7),
            Color.fromRGBO(0, 0, 0, 0.5),
            Color.fromRGBO(0, 0, 0, 0.3),
            Color.fromRGBO(0, 0, 0, 0.1),
            Color.fromRGBO(0, 0, 0, 0.0),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Back button
            Container(
              margin: const EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    ADColors.black.withOpacity(.30),
                    ADColors.black.withOpacity(.25),
                    ADColors.black.withOpacity(.20),
                    ADColors.black.withOpacity(.15),
                    ADColors.black.withOpacity(.10),
                    ADColors.black.withOpacity(.05),
                    ADColors.black.withOpacity(.01),
                  ],
                ),
              ),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Iconsax.arrow_left, color: ADColors.white),
              ),
            ),

            /// Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Texts
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(quiz.name, style: Theme.of(context).textTheme.headlineMedium!.apply(color: ADColors.white)),
                      Text(quiz.description, style: Theme.of(context).textTheme.bodySmall!.apply(color: ADColors.white)),
                    ],
                  ),
                ),

                Text("${quiz.questionCount.toString()} ta savol", style: Theme.of(context).textTheme.headlineMedium!.apply(color: ADColors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
