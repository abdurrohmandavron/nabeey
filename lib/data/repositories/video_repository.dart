import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../utils/constants/api_constants.dart';
import '../../features/explore/models/video_model.dart';
import '../../features/explore/models/youtube_video_model.dart';

import 'base_repository.dart';

class VideoRepository extends BaseRepository<VideoModel> {
  @override
  VideoModel fromJson(Map<String, dynamic> json) => VideoModel.fromJson(json);

  @override
  VideoModel empty() => VideoModel.empty();

  Future<Map<String, List<VideoModel>>> getVideos() async {
    final response = await httpClient.get(ADAPIs.videosR);
    final List<dynamic> videoListJson = response['data'] ?? [];
    final List<VideoModel> videos = videoListJson.map((videoJson) => VideoModel.fromJson(videoJson)).toList();

    Map<String, List<VideoModel>> videosByAuthor = {};

    for (var video in videos) {
      if (!videosByAuthor.containsKey(video.author)) {
        videosByAuthor[video.author] = [];
      }
      videosByAuthor[video.author]!.add(video);
    }

    return videosByAuthor;
  }

  Future<VideoModel?> getVideo(int videoId) => getById(ADAPIs.videoR, videoId);

  Future<void> createVideo(VideoModel video) => create(ADAPIs.videoC, video.toJson());

  Future<void> updateVideo(VideoModel video) => update(ADAPIs.videoU, video.id, video.toJson());

  Future<void> deleteVideo(int videoId) => delete(ADAPIs.videoD, videoId);

  Future<YouTubeVideoModel?> getVideoData(VideoModel video) async {
    final response = await httpClient.getVideoData(YoutubePlayer.convertUrlToId(video.videoLink)!);
    if (response.containsKey('items') && (response['items'] as List).isNotEmpty) {
      final firstItem = response['items'][0];
      return YouTubeVideoModel.fromJson(firstItem['snippet']);
    } else {
      return YouTubeVideoModel.empty();
    }
  }
}
