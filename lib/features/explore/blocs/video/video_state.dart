import 'package:equatable/equatable.dart';
import 'package:nabeey/features/explore/models/video_model.dart';
import 'package:nabeey/features/explore/models/youtube_video_model.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class VideoLoading extends VideoState {}

class VideoLoaded extends VideoState {
  final Map<String, List<VideoModel>> videos;
  final Map<String, List<YouTubeVideoModel>> ytVideos;

  const VideoLoaded(this.videos, this.ytVideos);

  @override
  List<Object> get props => [videos, ytVideos];

  @override
  String toString() => 'VideoLoaded';
}

class VideoEmpty extends VideoState {}

class VideoError extends VideoState {
  final String message;

  const VideoError(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'VideoError { message: $message }';
}
