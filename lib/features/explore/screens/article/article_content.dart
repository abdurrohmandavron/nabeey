import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:nabeey/common/widgets/appbar/appbar.dart';
import 'package:nabeey/common/widgets/images/rounded_image.dart';
import 'package:nabeey/features/explore/models/article_model.dart';
import 'package:nabeey/features/explore/screens/article/widgets/article_meta_row.dart';

class ArticleContent extends StatelessWidget {
  const ArticleContent({super.key, required this.article});

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ADAppBar(showBackArrow: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            AspectRatio(aspectRatio: 1.4, child: RoundedImage(imageUrl: article.image.filePath, fit: BoxFit.cover, isNetworkImage: true)),
            const SizedBox(height: 20),

            /// Name
            Text(article.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),

            /// Details Row
            kDebugMode ? const ArticleMetaRow(date: '08.10.2024', views: 1357) : const SizedBox(), // TODO
            kDebugMode ? const SizedBox(height: 25) : const SizedBox(), // TODO

            /// Content
            Text(article.text),
          ],
        ),
      ),
    );
  }
}
