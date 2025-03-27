import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:nabeey/utils/constants/colors.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  final String text;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: ADColors.grey),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: ADColors.primary,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Expanded(child: SizedBox()),
            const SizedBox(width: 16),
            const Icon(Feather.chevron_right, color: ADColors.darkGrey),
          ],
        ),
      ),
    );
  }
}
