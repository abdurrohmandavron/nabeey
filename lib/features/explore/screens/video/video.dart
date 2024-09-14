import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:nabeey/common/widgets/header/header.dart';
import 'package:nabeey/features/explore/models/category_model.dart';
import 'package:nabeey/features/explore/blocs/video/video_bloc.dart';
import 'package:nabeey/features/explore/blocs/video/video_event.dart';
import 'package:nabeey/features/explore/blocs/video/video_state.dart';
import 'package:nabeey/features/explore/screens/video/widgets/author_video_list.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<VideoBloc>(context);
    controller.add(LoadVideos());

    return Scaffold(
      body: BlocBuilder<VideoBloc, VideoState>(builder: (context, state) {
        if (state is VideoLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is VideoLoaded) {
          return Column(
            children: [
              /// Category Description
              ADHeader(category: category),

              /// Videos
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.videos.keys.toList().length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final author = state.videos.keys.toList()[index];
                      final videos = state.videos[author]!;
                      final ytVideos = state.ytVideos[author]!;
                      return AuthorVideoList(author: author, videos: videos, ytVideos: ytVideos);
                    },
                  ),
                ),
              )
            ],
          );
        } else if (state is VideoEmpty) {
          return Center(child: Padding(padding: const EdgeInsets.all(ADSizes.defaultSpace), child: Text("Video mavjud emas.", style: Theme.of(context).textTheme.bodyLarge)));
        } else if (state is VideoError) {
          return Center(child: Padding(padding: const EdgeInsets.all(ADSizes.defaultSpace), child: Text(state.message, style: Theme.of(context).textTheme.bodyLarge)));
        } else {
          return Center(child: Padding(padding: const EdgeInsets.all(ADSizes.defaultSpace), child: Text("Nimadir xato ketdi.", style: Theme.of(context).textTheme.bodyLarge)));
        }
      }),
    );
  }
}
