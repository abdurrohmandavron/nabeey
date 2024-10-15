import 'package:nabeey/features/explore/blocs/base/base_state.dart';
import 'package:nabeey/features/explore/models/video_model.dart';
import 'package:nabeey/features/explore/models/youtube_video_model.dart';

abstract class VideoState extends BaseState {
  const VideoState();
}

class VideosLoaded extends VideoState {
  final Map<String, List<VideoModel>> videos;
  final Map<String, List<VideoDataModel>> ytVideos;

  const VideosLoaded(this.videos, this.ytVideos);

  @override
  List<Object> get props => [videos, ytVideos];

  @override
  String toString() => 'VideoLoaded';
}
