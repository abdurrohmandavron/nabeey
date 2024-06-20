import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:nabeey/features/explore/controllers/author_videos_controller.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:nabeey/common/widgets/appbar/appbar.dart';
import 'package:nabeey/features/explore/models/video_model.dart';
import 'package:nabeey/features/explore/models/youtube_video_model.dart';
import 'package:nabeey/features/explore/screens/video/widgets/video_player.dart';
import 'package:nabeey/utils/formatters/formatter.dart';

class AuthorVideosScreen extends StatelessWidget {
  const AuthorVideosScreen({
    super.key,
    this.play,
    required this.videos,
    required this.ytVideos,
  });

  final int? play;
  final List<VideoModel> videos;
  final List<YouTubeVideoModel> ytVideos;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ScrollCubit(),
      child: BlocBuilder<ScrollCubit, void>(builder: (context, state) {
        final controller = context.read<ScrollCubit>();

        if (play != null && play! < videos.length) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.scrollToIndex(play!);
          });
        }

        return Scaffold(
          /// AppBar with Author name
          appBar: ADAppBar(title: Text("${videos[0].author} videolari"), showBackArrow: true),

          /// List of Videos
          body: Padding(
            padding: const EdgeInsets.all(ADSizes.md),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: videos.length,
              controller: controller.scrollController,
              separatorBuilder: (_, __) => const SizedBox(height: ADSizes.defaultSpace),
              itemBuilder: (context, index) {
                final video = videos[index];
                final ytVideo = ytVideos[index];

                return SizedBox(
                  height: 317,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// YouTube Player
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: VideoPlayer(
                          url: video.videoLink,
                          play: play != null && play == index ? true : false,
                        ),
                      ),
                      const SizedBox(height: ADSizes.spaceBtwItems),

                      /// Date
                      Text(Formatter.formatDate(DateTime.parse(ytVideo.date)), style: Theme.of(context).textTheme.labelLarge),

                      /// Title
                      Text(ytVideo.title, style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
