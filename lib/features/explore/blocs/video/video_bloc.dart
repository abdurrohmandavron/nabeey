import 'package:nabeey/data/repositories/video_repository.dart';
import 'package:nabeey/features/explore/models/video_model.dart';
import 'package:nabeey/features/explore/models/youtube_video_model.dart';

import '../base/base_bloc.dart';

import 'video_event.dart';
import 'video_state.dart';

class VideoBloc extends BaseBloc<VideoEvent, VideoState> {
  final VideoRepository videoRepository;

  VideoBloc(this.videoRepository) : super(VideoLoading()) {
    on<LoadVideos>((event, emit) async {
      try {
        final videos = await videoRepository.getVideos();

        if (videos.isEmpty) {
          emit(VideoEmpty());
          return;
        }

        Map<String, List<YouTubeVideoModel>> ytVideos = {};

        for (var author in videos.keys) {
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
      } catch (e) {
        handleError(emit, e);
      }
    });
  }
}
