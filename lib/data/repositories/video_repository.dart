import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../utils/constants/api_constants.dart';
import '../../features/explore/models/video_model.dart';
import '../../features/explore/models/youtube_video_model.dart';

import 'base_repository.dart';

class VideoRepository extends BaseRepository<VideoModel> {

  Future<Map<String, List<VideoModel>>> getVideos(int categoryId) async {
    final response = await httpClient.get(ADAPIs.endpoints['GETBYCATEGORY']![VideoModel]! + categoryId.toString());

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

  Future<VideoDataModel?> getVideoData(VideoModel video) async {
    final response = await httpClient.getVideoData(YoutubePlayer.convertUrlToId(video.videoLink)!);
    if (response.containsKey('items') && (response['items'] as List).isNotEmpty) {
      final firstItem = response['items'][0];
      return VideoDataModel.fromJson(firstItem['snippet']);
    } else {
      return VideoDataModel.empty();
    }
  }
}
