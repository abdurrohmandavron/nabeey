import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';

class ArticleMetaRow extends StatelessWidget {
  const ArticleMetaRow({super.key, required this.date, required this.views});

  final String date;
  final int views;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Date Icon
        const Icon(size: 18, Feather.calendar),
        const SizedBox(width: 5),

        /// Date
        Text(date, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(width: 26),

        /// Views Icon
        const Icon(size: 18, Feather.eye),
        const SizedBox(width: 5),

        /// View
        Text('$views views', style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
