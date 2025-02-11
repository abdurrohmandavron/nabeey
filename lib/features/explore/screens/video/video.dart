import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:nabeey/common/widgets/headers/header.dart';
import 'package:nabeey/features/explore/blocs/base/base_state.dart';
import 'package:nabeey/data/models/category_model.dart';
import 'package:nabeey/features/explore/blocs/video/video_bloc.dart';
import 'package:nabeey/features/explore/blocs/video/video_state.dart';
import 'package:nabeey/features/explore/screens/video/widgets/author_video_list.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// Category Description
          ADHeader(category: category),

          /// Videos
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: BlocBuilder<VideoBloc, BaseState>(
                builder: (context, state) {
                  if (state is ItemsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is VideosLoaded) {
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: state.videos.keys.toList().length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final author = state.videos.keys.toList()[index];
                        final videos = state.videos[author]!;
                        final ytVideos = state.ytVideos[author]!;
                        return AuthorVideoList(author: author, videos: videos, ytVideos: ytVideos);
                      },
                    );
                  } else if (state is ItemsError || state is ItemsEmpty) {
                    return Center(child: Padding(padding: const EdgeInsets.all(ADSizes.defaultSpace), child: Text(state.toString(), style: Theme.of(context).textTheme.bodyLarge)));
                  } else {
                    return Center(child: Padding(padding: const EdgeInsets.all(ADSizes.defaultSpace), child: Text("Nimadir xato ketdi.", style: Theme.of(context).textTheme.bodyLarge)));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
