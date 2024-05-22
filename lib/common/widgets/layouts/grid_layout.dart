import 'package:flutter/material.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:nabeey/utils/device/device_utility.dart';

class GridLayout extends StatelessWidget {
  const GridLayout({super.key, required this.itemCount, required this.itemBuilder});

  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    final double mainAxisExtent = ADDeviceUtils.getScreenWidth(context) / 3.37;
    return GridView.builder(
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: ADSizes.gridViewSpacing,
        crossAxisSpacing: ADSizes.gridViewSpacing,
        mainAxisExtent: mainAxisExtent,
      ),
    );
  }
}
