import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:nabeey/utils/constants/colors.dart';
import 'package:nabeey/common/widgets/images/rounded_image.dart';
import 'package:nabeey/features/explore/models/video_model.dart';
import 'package:nabeey/features/explore/models/youtube_video_model.dart';
import 'package:nabeey/features/explore/screens/video/author_videos_screen.dart';

class AuthorVideoItem extends StatelessWidget {
  const AuthorVideoItem({
    super.key,
    required this.index,
    required this.videos,
    required this.ytVideos,
  });

  final int index;
  final List<VideoModel> videos;
  final List<YouTubeVideoModel> ytVideos;

  @override
  Widget build(BuildContext context) {
  final VideoModel video = videos[index];
  final YouTubeVideoModel ytVideo = ytVideos[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// Poster
        AspectRatio(
          aspectRatio: 0.7,
          child: Stack(
            children: [
              /// Thumbnail
              RoundedImage(imageUrl: ytVideo.image, borderRadius: ADSizes.borderRadiusMd, isNetworkImage: true),

              /// Play Button
              Center(
                child: IconButton(
                  icon: const Icon(Feather.play_circle, color: ADColors.white),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AuthorVideosScreen(videos: videos, ytVideos: ytVideos, play: video.id))),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: ADSizes.sm),

        /// Title
        Text(video.title, style: Theme.of(context).textTheme.labelLarge!.apply(overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}
