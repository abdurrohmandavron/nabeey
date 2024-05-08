import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:nabeey/common/widgets/header/header.dart';
import 'package:nabeey/features/explore/models/category_model.dart';
import 'package:nabeey/features/explore/controllers/article_controller.dart';
import 'package:nabeey/features/explore/screens/article/widgets/article_item.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<ArticleController>(context);
    controller.add(const LoadArticles());

    return Scaffold(
      body: BlocBuilder<ArticleController, ArticleState>(
        builder: (context, state) {
          if (state is ArticleLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ArticleLoaded) {
            return Column(
              children: [
                /// Category Description
                ADHeader(category: category),

                /// Articles
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: state.articles.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 24),
                      itemBuilder: (context, index) {
                        final article = state.articles[index];
                        return ArticleItem(article: article);
                      },
                    ),
                  ),
                )
              ],
            );
          } else if (state is ArticleError) {
            return Center(child: Padding(padding: const EdgeInsets.all(ADSizes.defaultSpace), child: Text(state.message, style: Theme.of(context).textTheme.bodyLarge)));
          } else {
            return Center(child: Padding(padding: const EdgeInsets.all(ADSizes.defaultSpace), child: Text("Nimadir xato ketdi.", style: Theme.of(context).textTheme.bodyLarge)));
          }
        },
      ),
    );
  }
}
