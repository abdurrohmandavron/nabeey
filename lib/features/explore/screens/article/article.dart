import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/features/explore/models/article_model.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:nabeey/common/widgets/header/header.dart';
import 'package:nabeey/features/explore/blocs/base/base_bloc.dart';
import 'package:nabeey/features/explore/blocs/base/base_state.dart';
import 'package:nabeey/features/explore/models/category_model.dart';
import 'package:nabeey/features/explore/screens/article/widgets/article_item.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BaseBloc<ArticleModel>, BaseState>(
        builder: (context, state) {
          if (state is ItemsInit) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ItemsLoaded) {
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
                      itemCount: state.items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 24),
                      itemBuilder: (context, index) {
                        final ArticleModel article = state.items[index];
                        return ArticleItem(article: article);
                      },
                    ),
                  ),
                )
              ],
            );
          } else if (state is ItemsError || state is ItemsEmpty) {
            return Center(child: Padding(padding: const EdgeInsets.all(ADSizes.defaultSpace), child: Text(state.toString(), style: Theme.of(context).textTheme.bodyLarge)));
          } else {
            return Center(child: Padding(padding: const EdgeInsets.all(ADSizes.defaultSpace), child: Text("Noma'lum xatolik!", style: Theme.of(context).textTheme.bodyLarge)));
          }
        },
      ),
    );
  }
}
