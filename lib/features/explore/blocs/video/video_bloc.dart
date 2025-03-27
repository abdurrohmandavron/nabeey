import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/data/repositories/video_repository.dart';
import 'package:nabeey/features/explore/blocs/base/base_event.dart';
import 'package:nabeey/features/explore/blocs/base/base_state.dart';
import 'package:nabeey/features/explore/models/video_model.dart';
import 'package:nabeey/features/explore/models/youtube_video_model.dart';
import 'package:nabeey/utils/helpers/network_manager.dart';

import '../../../../utils/logging/logger.dart';
import 'video_state.dart' as video_state;

class VideoBloc extends Bloc<BaseEvent, BaseState> {
  final VideoRepository videoRepository;
  final NetworkManager _networkManager;

  VideoBloc({
    required this.videoRepository,
    required NetworkManager networkManager,
  })  : _networkManager = networkManager,
        super(ItemsLoading()) {
    on<LoadItems>(_handleLoadItems);

    add(LoadItems());
  }

  Future<void> _handleLoadItems(LoadItems event, Emitter<BaseState> emit) async {
    try {
      // Check internet connection
      if (!await _networkManager.isConnected()) {
        emit(const ItemsError("Internet aloqasi yo'q"));
        return;
      }

      emit(ItemsLoading());

      final videos = await videoRepository.getVideos();
      if (videos.isEmpty) {
        emit(ItemsEmpty());
        return;
      }

      final ytVideos = await _loadYoutubeData(videos);

      if (ytVideos.isEmpty) {
        emit(const ItemsError('YouTube ma\'lumotlarini yuklashda xatolik'));
        return;
      }

      emit(video_state.VideosLoaded(videos, ytVideos));
    } catch (e) {
      _handleError('Video loading failed', e);
      emit(ItemsError(e.toString()));
    }
  }

  Future<Map<String, List<VideoDataModel>>> _loadYoutubeData(Map<String, List<VideoModel>> videos) async {
    final results = await Future.wait(
      videos.entries.map((entry) => _processAuthorVideos(entry.key, entry.value)),
      cleanUp: (successValue) {
        // Clean up logic if needed
      },
    );

    return Map.fromEntries(results.whereType<MapEntry<String, List<VideoDataModel>>>());
  }

  Future<MapEntry<String, List<VideoDataModel>>?> _processAuthorVideos(String author, List<VideoModel> videos) async {
    try {
      final ytVideosList = <VideoDataModel>[];

      for (var video in videos) {
        try {
          final ytVideo = await videoRepository.getVideoData(video);
          if (ytVideo != null) {
            ytVideosList.add(ytVideo);
          }
        } catch (e) {
          _handleError('Failed to load video ${video.id}', e, isCritical: false);
        }
      }

      return MapEntry(author, ytVideosList);
    } catch (e) {
      _handleError('Failed to process videos for $author', e);
      return null;
    }
  }

  void _handleError(String message, dynamic error, {bool isCritical = true}) {
    final errorMessage = '$message: $error';
    isCritical ? LoggerHelper.error(errorMessage) : LoggerHelper.warning(errorMessage);
  }
}
