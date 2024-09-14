import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/utils/exceptions/exceptions.dart';
import 'package:nabeey/data/repositories/video_repository.dart';
import 'package:nabeey/features/explore/models/video_model.dart';
import 'package:nabeey/features/explore/models/youtube_video_model.dart';

import 'video_event.dart';
import 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final VideoRepositoryImpl videoRepository = VideoRepositoryImpl();

  VideoBloc() : super(VideoLoading()) {
    on<LoadVideos>((event, emit) async {
      try {
        final videos = await videoRepository.getVideos();

        if (videos.isEmpty) emit(VideoEmpty());

        Map<String, List<YouTubeVideoModel>> ytVideos = {};

        for (var author in videos.keys.toList()) {
          List<YouTubeVideoModel> ytVideosList = [];

          for (VideoModel video in videos[author]!) {
            final ytVideo = await videoRepository.getVideoData(video);

            if (ytVideo != null) {
              ytVideosList.add(ytVideo);
            } else {
              emit(VideoError('Failed to fetch YouTube data for video: ${video.id}'));
            }
          }
          ytVideos[author] = ytVideosList;
        }

        emit(VideoLoaded(videos, ytVideos));
      } on SocketException {
        emit(const VideoError("Server bilan bog'lanib bo'lmadi"));
      } catch (e) {
        ADException(e);
        emit(VideoError(e.toString()));
      }
    });
  }
}
