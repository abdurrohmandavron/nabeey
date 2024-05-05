import 'package:flutter/material.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:nabeey/utils/constants/colors.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage({
    super.key,
    this.child,
    this.border,
    this.margin,
    this.padding,
    this.onPressed,
    this.height = 200,
    required this.imageUrl,
    this.fit = BoxFit.contain,
    this.isNetworkImage = false,
    this.width = double.infinity,
    this.applyImageRadius = true,
    this.borderRadius = ADSizes.md,
    this.backgroundColor = ADColors.light,
  });

  final BoxFit fit;
  final Widget? child;
  final String imageUrl;
  final BoxBorder? border;
  final double borderRadius;
  final bool isNetworkImage;
  final double width, height;
  final bool applyImageRadius;
  final Color backgroundColor;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          image: DecorationImage(image: isNetworkImage ? NetworkImage(imageUrl) : AssetImage(imageUrl) as ImageProvider),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius ? BorderRadius.circular(borderRadius) : BorderRadius.zero,
          child: child,
        ),
      ),
    );
  }
}
