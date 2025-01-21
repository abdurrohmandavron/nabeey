import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/common/widgets/headers/header.dart';
import 'package:nabeey/utils/helpers/check_bloc_state.dart';
import 'package:nabeey/features/explore/models/article_model.dart';
import 'package:nabeey/features/explore/blocs/base/base_bloc.dart';
import 'package:nabeey/features/explore/blocs/base/base_state.dart';
import 'package:nabeey/data/models/category_model.dart';
import 'package:nabeey/features/explore/screens/article/widgets/article_item.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// Category Description
          ADHeader(category: category),

          /// Articles
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: BlocBuilder<BaseBloc<ArticleModel>, BaseState>(
                builder: (context, state) {
                  return CheckBlocState.checkState(context, state) ??
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: (state as ItemsLoaded).items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 24),
                        itemBuilder: (context, index) {
                          final article = state.items[index];
                          return ArticleItem(article: article);
                        },
                      );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
