import 'package:flutter/material.dart';
import 'package:nabeey/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:nabeey/common/widgets/header/header.dart';
import 'package:nabeey/common/widgets/layouts/grid_layout.dart';
import 'package:nabeey/features/explore/screens/book/book.dart';
import 'package:nabeey/features/explore/screens/audio/audio.dart';
import 'package:nabeey/features/explore/screens/video/video.dart';
import 'package:nabeey/features/explore/blocs/book/book_bloc.dart';
import 'package:nabeey/features/explore/models/category_model.dart';
import 'package:nabeey/features/explore/blocs/video/video_bloc.dart';
import 'package:nabeey/features/explore/blocs/audio/audio_bloc.dart';
import 'package:nabeey/features/explore/screens/article/article.dart';
import 'package:nabeey/features/explore/blocs/article/article_bloc.dart';
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
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => contentPage(context, index))),
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
        return BlocProvider<ArticleBloc>(
          create: (_) => getIt<ArticleBloc>(),
          child: ArticleScreen(category: category),
        );
      case 1:
        return BlocProvider<VideoBloc>(
          create: (_) => getIt<VideoBloc>(),
          child: VideoScreen(category: category),
        );
      case 2:
        return BlocProvider<AudioBloc>(
          create: (_) => getIt<AudioBloc>(),
          child: AudioScreen(category: category),
        );
      case 3:
      default:
        return BlocProvider(
          create: (_) => getIt<BookBloc>(),
          child: BookScreen(category: category),
        );
    }
  }
}
