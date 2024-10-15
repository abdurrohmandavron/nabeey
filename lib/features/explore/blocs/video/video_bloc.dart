import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/data/repositories/video_repository.dart';
import 'package:nabeey/features/explore/blocs/base/base_event.dart';
import 'package:nabeey/features/explore/blocs/base/base_state.dart';
import 'package:nabeey/features/explore/models/video_model.dart';
import 'package:nabeey/features/explore/models/youtube_video_model.dart';

import 'video_state.dart' as video_state;

class VideoBloc extends Bloc<BaseEvent, BaseState> {
  final VideoRepository videoRepository;

  VideoBloc(this.videoRepository) : super(ItemsInit()) {
    on<LoadItems>((event, emit) async {
      try {
        final videos = await videoRepository.getVideos(0);

        if (videos.isEmpty) {
          emit(ItemsEmpty());
          return;
        }

        Map<String, List<VideoDataModel>> ytVideos = {};

        for (var author in videos.keys) {
          List<VideoDataModel> ytVideosList = [];

          for (VideoModel video in videos[author]!) {
            final ytVideo = await videoRepository.getVideoData(video);
            if (ytVideo != null) {
              ytVideosList.add(ytVideo);
            } else {
              emit(ItemsError('Failed to fetch YouTube data for video: ${video.id}'));
            }
          }
          ytVideos[author] = ytVideosList;
        }

        emit(video_state.VideosLoaded(videos, ytVideos));
      } catch (e) {
        emit(ItemsError(e.toString()));
      }
    });
  }
}
