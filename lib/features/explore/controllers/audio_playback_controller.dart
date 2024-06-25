import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:nabeey/features/explore/models/audio_model.dart';
import 'package:nabeey/features/explore/controllers/audio_controller.dart';

class PlaybackController extends Cubit<PlaybackState> {
  PlaybackController({required this.audioController}) : super(PlaybackInitial()) {
    _audioPlayer = AudioPlayer();
    _initAudioPlayer();
  }

  AudioModel? _currentAudio;
  late AudioPlayer _audioPlayer;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  final AudioController audioController;

  void _initAudioPlayer() {
    _audioPlayer.onPositionChanged.listen((position) {
      _position = position;
      if (audioController.playingAudio != _currentAudio) {
        pause();
      }
      if (state is PlaybackPlaying) {
        emit(PlaybackPlaying(position: _position, duration: _duration, audio: _currentAudio!));
      } else if (state is PlaybackPaused) {
        emit(PlaybackPaused(position: _position, duration: _duration, audio: _currentAudio!));
      }
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      _duration = duration;
      if (state is PlaybackPlaying) {
        emit(PlaybackPlaying(position: _position, duration: _duration, audio: _currentAudio!));
      } else if (state is PlaybackPaused) {
        emit(PlaybackPaused(position: _position, duration: _duration, audio: _currentAudio!));
      }
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      _position = Duration.zero;
      emit(PlaybackPaused(position: _position, duration: _duration, audio: _currentAudio!));
    });
  }

  Future<void> play(AudioModel audio) async {
    if (_currentAudio != null && _currentAudio != audio) {
      await _audioPlayer.stop();
    }
    _currentAudio = audio;
    audioController.playingAudio = _currentAudio;
    await _audioPlayer.play(UrlSource(audio.audio.filePath));
    emit(PlaybackPlaying(position: _position, duration: _duration, audio: _currentAudio!));
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    emit(PlaybackPaused(position: _position, duration: _duration, audio: _currentAudio!));
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
    _position = position;
    if (state is PlaybackPlaying) {
      emit(PlaybackPlaying(position: _position, duration: _duration, audio: _currentAudio!));
    } else if (state is PlaybackPaused) {
      emit(PlaybackPaused(position: _position, duration: _duration, audio: _currentAudio!));
    }
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    _position = Duration.zero;
    emit(PlaybackPaused(position: _position, duration: _duration, audio: _currentAudio!));
  }
}

// PlaybackState represents the state of the PlaybackController
abstract class PlaybackState extends Equatable {
  const PlaybackState({
    required this.position,
    required this.duration,
    required this.audio,
  });

  final Duration position;
  final Duration duration;
  final AudioModel audio;

  @override
  List<Object> get props => [position, duration, audio];
}

class PlaybackInitial extends PlaybackState {
  PlaybackInitial() : super(position: Duration.zero, duration: Duration.zero, audio: AudioModel.empty());
}

class PlaybackPlaying extends PlaybackState {
  const PlaybackPlaying({required super.position, required super.duration, required super.audio});
}

class PlaybackPaused extends PlaybackState {
  const PlaybackPaused({required super.position, required super.duration, required super.audio});
}
