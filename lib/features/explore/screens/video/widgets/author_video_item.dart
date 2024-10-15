import 'package:flutter/material.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:nabeey/utils/formatters/formatter.dart';
import 'package:nabeey/features/explore/models/video_model.dart';
import 'package:nabeey/features/explore/models/youtube_video_model.dart';
import 'package:nabeey/features/explore/screens/video/widgets/video_player.dart';

class AuthorVideoItem extends StatelessWidget {
  const AuthorVideoItem({
    super.key,
    required this.play,
    required this.index,
    required this.video,
    required this.ytVideo,
  });

  final VideoModel video;
  final int? play;
  final int index;
  final VideoDataModel ytVideo;

  @override
  Widget build(BuildContext context) {
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
  }
}
