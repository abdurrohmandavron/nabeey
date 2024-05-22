import 'package:flutter/material.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:nabeey/common/widgets/appbar/appbar.dart';
import 'package:nabeey/features/explore/models/video_model.dart';
import 'package:nabeey/features/explore/models/youtube_video_model.dart';
import 'package:nabeey/features/explore/screens/video/widgets/video_player.dart';

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
    if (play != null) {
      double scrollOffset = play! * 300.0;
      ScrollController().animateTo(scrollOffset, duration: const Duration(milliseconds: 500), curve: Curves.ease);
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
          separatorBuilder: (_, __) => const SizedBox(height: ADSizes.defaultSpace),
          itemBuilder: (context, index) {
            final video = videos[index];
            final ytVideo = ytVideos[index];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// YouTube Player
                ClipRRect(borderRadius: BorderRadius.circular(20), child: VideoPlayer(url: video.videoLink, play: play != null ? true : false)),

                /// Date & Views
                Row(
                  children: [
                    Text(ytVideo.date, style: Theme.of(context).textTheme.labelLarge),
                    Text(ytVideo.views.toString(), style: Theme.of(context).textTheme.labelLarge),
                  ],
                ),

                /// Title
                Text(ytVideo.title, style: Theme.of(context).textTheme.titleMedium),
              ],
            );
          },
        ),
      ),
    );
  }
}
