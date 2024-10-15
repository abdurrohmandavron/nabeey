import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:nabeey/common/widgets/appbar/appbar.dart';
import 'package:nabeey/features/explore/models/video_model.dart';
import 'package:nabeey/features/explore/models/youtube_video_model.dart';
import 'package:nabeey/features/explore/cubits/video/author_videos_cubit.dart';
import 'package:nabeey/features/explore/screens/video/widgets/author_video_item.dart';

class AuthorVideosScreen extends StatelessWidget {
  const AuthorVideosScreen({
    super.key,
    this.play,
    required this.videos,
    required this.ytVideos,
  });

  final int? play;
  final List<VideoModel> videos;
  final List<VideoDataModel> ytVideos;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthorVideosCubit(),
      child: BlocBuilder<AuthorVideosCubit, void>(
        builder: (context, state) {
          final controller = context.read<AuthorVideosCubit>();

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

                  return AuthorVideoItem(
                    play: play,
                    index: index,
                    video: video,
                    ytVideo: ytVideo,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
