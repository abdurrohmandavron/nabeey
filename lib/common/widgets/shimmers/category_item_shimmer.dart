import 'package:flutter/material.dart';
import 'package:nabeey/common/widgets/shimmers/shimmer.dart';

class CategoryItemShimmer extends StatelessWidget {
  const CategoryItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const AspectRatio(
      aspectRatio: 1.5,
      child: ADShimmerEffect(width: double.infinity, height: double.infinity),
    );
  }
}
