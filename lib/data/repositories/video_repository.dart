import 'package:flutter/material.dart';
import 'package:nabeey/utils/logging/logger.dart';
import 'package:nabeey/utils/http/http_client.dart';
import 'package:nabeey/features/explore/models/video_model.dart';
import 'package:nabeey/features/explore/models/youtube_video_model.dart';

abstract class VideoRepository {
  @protected
  Future<Map<String, dynamic>> getVideos();

  Future<VideoModel?> getVideo(int videoId);

  Future<void> createVideo(VideoModel video);

  Future<void> updateVideo(VideoModel video);

  Future<void> deleteVideo(int videoId);

  Future<YouTubeVideoModel?> getVideoData(VideoModel video);
}

class VideoRepositoryImpl implements VideoRepository {
  final HttpHelper _httpClient = HttpHelper();

  VideoRepositoryImpl();

  @override
  Future<Map<String, List<VideoModel>>> getVideos() async {
    final response = await _httpClient.get(HttpHelper.videosR);
    final List<dynamic> videoListJson = response['data'];
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

  @override
  Future<VideoModel?> getVideo(int videoId) async {
    final response = await _httpClient.get('${HttpHelper.videoR}/$videoId');
    // Handle API response (error checking, data parsing)
    return response['data'] != null ? VideoModel.fromJson(response['data']) : null;
  }

  @override
  Future<void> createVideo(VideoModel video) async {
    // Send create Video request to API
    await _httpClient.post(HttpHelper.videoC, video.toJson());
  }

  @override
  Future<void> updateVideo(VideoModel video) async {
    // Send update Video request to API
    await _httpClient.put(HttpHelper.videoU + video.id.toString(), video.toJson());
  }

  @override
  Future<void> deleteVideo(int videoId) async {
    // Send delete Video request to API
    await _httpClient.delete(HttpHelper.videoD + videoId.toString());
  }

  @override
  Future<YouTubeVideoModel?> getVideoData(VideoModel video) async {
    final response = await _httpClient.getVideoData(parser(video.videoLink));
    LoggerHelper.info(parser(video.videoLink));

    if (response.containsKey('items') && (response['items'] as List).isNotEmpty) {
      final firstItem = response['items'][0]; // Get the first video entry
      return YouTubeVideoModel.fromJson(firstItem['snippet']); // Parse snippet for data
    } else {
      return null;
    }
  }

  String parser(String url) {
    const regex = r"(?:https?://)?(?:www\.)?(?:youtube\.com|youtu\.be)/watch\?v=([^#&?]+)|(?:https?://)?(?:www\.)?(?:youtu\.be)/([^#&?]+)";
    final match = RegExp(regex).firstMatch(url);

    if (match != null) return match.group(1) ?? match.group(2)!;

    return 'u31qwQUeGuM';
  }
}
