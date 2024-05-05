import 'package:flutter/material.dart';
import 'package:nabeey/features/explore/models/article_model.dart';
import 'package:nabeey/utils/constants/colors.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({super.key, required this.article});

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return Container(color: ADColors.white, width: double.infinity, height: 200,);
  }
}
