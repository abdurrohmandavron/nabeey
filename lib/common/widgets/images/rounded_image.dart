import 'package:flutter/material.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:nabeey/utils/constants/colors.dart';
import 'package:nabeey/common/widgets/shimmers/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage({
    super.key,
    this.child,
    this.border,
    this.margin,
    this.padding,
    this.gradient,
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
  final Gradient? gradient;
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
        decoration: BoxDecoration(border: border, color: backgroundColor, borderRadius: BorderRadius.circular(borderRadius)),
        child: Stack(
          children: [
            /// Image
            ClipRRect(
              borderRadius: applyImageRadius ? BorderRadius.circular(borderRadius) : BorderRadius.zero,
              child: isNetworkImage
                  ? CachedNetworkImage(
                      fit: fit,
                      imageUrl: imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: (_, __) => const ADShimmerEffect(width: double.infinity, height: double.infinity),
                    )
                  : Image.asset(
                      fit: fit,
                      imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                    ),
            ),

            /// Child
            Container(
              padding: padding,
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: applyImageRadius ? BorderRadius.circular(borderRadius) : BorderRadius.zero,
              ),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
