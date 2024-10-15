import 'package:flutter/material.dart';
import 'package:nabeey/features/explore/models/video_model.dart';
import 'package:nabeey/common/widgets/texts/section_heading.dart';
import 'package:nabeey/features/explore/models/youtube_video_model.dart';
import 'package:nabeey/features/explore/screens/video/author_videos_screen.dart';
import 'package:nabeey/features/explore/screens/video/widgets/author_video_list_item.dart';
import 'package:nabeey/utils/constants/sizes.dart';

class AuthorVideoList extends StatelessWidget {
  const AuthorVideoList({
    super.key,
    required this.author,
    required this.videos,
    required this.ytVideos,
  });

  final String author;
  final List<VideoModel> videos;
  final List<VideoDataModel> ytVideos;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeading(
          title: author,
          showActionButton: true,
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AuthorVideosScreen(videos: videos, ytVideos: ytVideos))),
        ),
        SizedBox(
          height: 180,
          child: ListView.separated(
            itemCount: videos.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => const SizedBox(width: ADSizes.spaceBtwItems),
            itemBuilder: (context, index) => AuthorVideoListItem(videos: videos, ytVideos: ytVideos, index: index),
          ),
        ),
      ],
    );
  }
}
