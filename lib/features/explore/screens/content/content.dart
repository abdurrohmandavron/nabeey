import 'package:flutter/material.dart';
import 'package:nabeey/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:nabeey/common/widgets/header/header.dart';
import 'package:nabeey/features/explore/models/book_model.dart';
import 'package:nabeey/common/widgets/layouts/grid_layout.dart';
import 'package:nabeey/features/explore/screens/book/book.dart';
import 'package:nabeey/features/explore/models/video_model.dart';
import 'package:nabeey/features/explore/models/audio_model.dart';
import 'package:nabeey/features/explore/screens/audio/audio.dart';
import 'package:nabeey/features/explore/screens/video/video.dart';
import 'package:nabeey/features/explore/blocs/base/base_bloc.dart';
import 'package:nabeey/features/explore/models/article_model.dart';
import 'package:nabeey/features/explore/models/category_model.dart';
import 'package:nabeey/features/explore/screens/article/article.dart';
import 'package:nabeey/features/explore/screens/content/widgets/content_item.dart';

class ContentScreen extends StatelessWidget {
  const ContentScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// Category Description
          ADHeader(category: category),

          /// Content Types
          Padding(
            padding: const EdgeInsets.all(ADSizes.defaultSpace),
            child: GridLayout(
              itemCount: 4,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => contentPage(context, index),
                    ),
                  ),
                  child: ContentItem(index: index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget contentPage(BuildContext contex, int index) {
    switch (index) {
      case 0:
        return BlocProvider<BaseBloc<ArticleModel>>(
          create: (_) => getIt<BaseBloc<ArticleModel>>(),
          child: ArticleScreen(category: category),
        );
      case 1:
        return BlocProvider<BaseBloc<VideoModel>>(
          create: (_) => getIt<BaseBloc<VideoModel>>(),
          child: VideoScreen(category: category),
        );
      case 2:
        return BlocProvider<BaseBloc<AudioModel>>(
          create: (_) => getIt<BaseBloc<AudioModel>>(),
          child: AudioScreen(category: category),
        );
      case 3:
      default:
        return BlocProvider<BaseBloc<BookModel>>(
          create: (_) => getIt<BaseBloc<BookModel>>(),
          child: BookScreen(category: category),
        );
    }
  }
}
