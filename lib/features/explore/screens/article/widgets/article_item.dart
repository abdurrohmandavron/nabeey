import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:nabeey/utils/constants/colors.dart';
import 'package:nabeey/utils/helpers/helper_functions.dart';
import 'package:nabeey/features/explore/models/article_model.dart';
import 'package:nabeey/features/explore/screens/article/article_content.dart';
import 'package:nabeey/features/explore/screens/article/widgets/article_meta_row.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({super.key, required this.article});

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return GestureDetector(
      // See content of Article
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleContent(article: article))),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: dark ? ADColors.darkerGrey : ADColors.accent, borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(article.image.filePath.toString())),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(article.title.toString(), style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: ADSizes.sm),
                    Text(maxLines: 3, article.text.toString(), style: const TextStyle(overflow: TextOverflow.ellipsis)),
                    const SizedBox(height: 12),
                    kDebugMode ? const ArticleMetaRow(date: '08.10.2024', views: 1357) : const SizedBox(), // TODO
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
