import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:nabeey/utils/constants/colors.dart';

class AnimationLoaderWidget extends StatelessWidget {
  const AnimationLoaderWidget({super.key, required this.text, required this.animation, this.showAction = false, this.actionText, this.onActionPressed});

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Lottie.asset(animation, width: MediaQuery.of(context).size.width * 0.8, fit: BoxFit.contain),
        const SizedBox(height: ADSizes.defaultSpace),
        Text(text, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
        const SizedBox(height: ADSizes.defaultSpace),
        showAction
            ? SizedBox(
                width: 250,
                child: OutlinedButton(
                  onPressed: onActionPressed,
                  style: OutlinedButton.styleFrom(backgroundColor: ADColors.dark),
                  child: Text(actionText!, style: Theme.of(context).textTheme.bodyMedium!.apply(color: ADColors.light)),
                ),
              )
            : const SizedBox()
      ]),
    );
  }
}
