import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/utils/exceptions/exceptions.dart';
import 'package:nabeey/data/repositories/video_repository.dart';
import 'package:nabeey/features/explore/models/video_model.dart';
import 'package:nabeey/features/explore/models/youtube_video_model.dart';

class VideoController extends Bloc<VideoEvent, VideoState> {
  final VideoRepositoryImpl videoRepository = VideoRepositoryImpl();

  VideoController() : super(const VideoLoading()) {
    on<LoadVideos>((event, emit) async {
      try {
        final videos = await videoRepository.getVideos();

        if (videos.isEmpty) emit(const VideoEmpty());

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

// VideoEvent represents that the VideoBloc can react to
abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

class LoadVideos extends VideoEvent {
  const LoadVideos();

  @override
  String toString() => 'LoadVideos';
}

// VideoState represents the state of VideoBloc
abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class VideoLoading extends VideoState {
  const VideoLoading();

  @override
  String toString() => 'VideoLoading';
}

class VideoLoaded extends VideoState {
  final Map<String, List<VideoModel>> videos;
  final Map<String, List<YouTubeVideoModel>> ytVideos;

  const VideoLoaded(this.videos, this.ytVideos);

  @override
  List<Object> get props => [videos, ytVideos];

  @override
  String toString() => 'VideoLoaded';
}

class VideoEmpty extends VideoState {
  const VideoEmpty();

  @override
  String toString() => 'VideoEmpty';
}

class VideoError extends VideoState {
  final String message;

  const VideoError(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'VideoError { message: $message }';
}
