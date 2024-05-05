
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';

class ArticleDetailsRow extends StatelessWidget {
  const ArticleDetailsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Feather.calendar, size: 18),
        SizedBox(width: 5),
        Text("30.09.2023", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
        SizedBox(width: 26),
        Icon(Feather.eye, size: 18),
        SizedBox(width: 5),
        Text("124", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
        SizedBox(height: 12),
      ],
    );
  }
}
