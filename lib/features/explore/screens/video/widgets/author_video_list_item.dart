import 'package:flutter/material.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:nabeey/utils/constants/colors.dart';
import 'package:nabeey/common/widgets/images/rounded_image.dart';
import 'package:nabeey/features/explore/models/video_model.dart';
import 'package:nabeey/features/explore/models/youtube_video_model.dart';
import 'package:nabeey/features/explore/screens/video/author_videos_screen.dart';

class AuthorVideoListItem extends StatelessWidget {
  const AuthorVideoListItem({
    super.key,
    required this.index,
    required this.videos,
    required this.ytVideos,
  });

  final int index;
  final List<VideoModel> videos;
  final List<VideoDataModel> ytVideos;

  @override
  Widget build(BuildContext context) {
    final VideoModel video = videos[index];
    final VideoDataModel ytVideo = ytVideos[index];

    return SizedBox(
      width: 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Poster
          SizedBox(
            height: 130,
            child: Stack(
              children: [
                /// Thumbnail
                RoundedImage(
                  imageUrl: ytVideo.image,
                  borderRadius: ADSizes.borderRadiusMd,
                  isNetworkImage: true,
                  fit: BoxFit.cover,
                ),

                /// Play Button
                Center(
                  child: IconButton(
                    icon: const Icon(Icons.play_circle, color: ADColors.white),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return AuthorVideosScreen(videos: videos, ytVideos: ytVideos, play: index);
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: ADSizes.sm),

          /// Title
          Text(video.title, style: Theme.of(context).textTheme.labelLarge!.apply(overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
