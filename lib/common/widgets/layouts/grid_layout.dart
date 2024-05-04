import 'package:flutter/material.dart';
import 'package:nabeey/utils/constants/sizes.dart';

class GridLayout extends StatelessWidget {
  const GridLayout({super.key, required this.itemCount, required this.itemBuilder, this.mainAxisExtent = 288});

  final int itemCount;
  final double mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: ADSizes.gridViewSpacing, crossAxisSpacing: ADSizes.gridViewSpacing, mainAxisExtent: mainAxisExtent),
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
