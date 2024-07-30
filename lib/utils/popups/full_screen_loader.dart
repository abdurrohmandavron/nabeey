import 'package:flutter/material.dart';
import 'package:nabeey/utils/constants/colors.dart';
import 'package:nabeey/utils/helpers/helper_functions.dart';
import 'package:nabeey/common/widgets/loaders/animation_loader.dart';

class FullScreenLoader {
  static void openLoadingDialog(BuildContext context, String text, String animation) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: Material(
          color: HelperFunctions.isDarkMode(context) ? ADColors.dark : ADColors.white,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 250),
                AnimationLoaderWidget(text: text, animation: animation),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void stopLoading(BuildContext context) {
    Navigator.of(context).pop();
  }
}
