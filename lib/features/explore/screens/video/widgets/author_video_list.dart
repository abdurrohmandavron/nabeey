import 'package:flutter/material.dart';
import 'package:nabeey/features/explore/models/video_model.dart';
import 'package:nabeey/common/widgets/texts/section_heading.dart';
import 'package:nabeey/features/explore/models/youtube_video_model.dart';
import 'package:nabeey/features/explore/screens/video/author_videos_screen.dart';
import 'package:nabeey/features/explore/screens/video/widgets/author_video_item.dart';

class AuthorVideoList extends StatelessWidget {
  const AuthorVideoList({
    super.key,
    required this.author,
    required this.videos,
    required this.ytVideos,
  });

  final String author;
  final List<VideoModel> videos;
  final List<YouTubeVideoModel> ytVideos;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeading(
          title: author,
          showActionButton: true,
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AuthorVideosScreen(videos: videos, ytVideos: ytVideos))),
        ),
        ListView.separated(
          itemCount: videos.length,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) => AuthorVideoItem(videos: videos, ytVideos: ytVideos, index: index),
        ),
      ],
    );
  }
}
