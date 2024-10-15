import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:nabeey/features/explore/blocs/base/base_bloc.dart';

import 'package:nabeey/features/explore/models/audio_model.dart';
import 'audio_playback_state.dart';

class AudioPlaybackCubit extends Cubit<AudioPlaybackState> {
  AudioPlaybackCubit(this.bloc) : super(AudioPlaybackInitial()) {
    _audioPlayer = AudioPlayer();
    _initAudioPlayer();
  }

  AudioModel? _currentAudio;
  late AudioPlayer _audioPlayer;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  BaseBloc<AudioModel> bloc;

  void _initAudioPlayer() {
    _audioPlayer.onPositionChanged.listen((position) {
      _position = position;
      if (bloc.playingAudio != _currentAudio) {
        pause();
      }
      if (state is AudioPlaybackPlaying) {
        emit(AudioPlaybackPlaying(position: _position, duration: _duration, audio: _currentAudio!));
      } else if (state is AudioPlaybackPaused) {
        emit(AudioPlaybackPaused(position: _position, duration: _duration, audio: _currentAudio!));
      }
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      _duration = duration;
      if (state is AudioPlaybackPlaying) {
        emit(AudioPlaybackPlaying(position: _position, duration: _duration, audio: _currentAudio!));
      } else if (state is AudioPlaybackPaused) {
        emit(AudioPlaybackPaused(position: _position, duration: _duration, audio: _currentAudio!));
      }
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      _position = Duration.zero;
      emit(AudioPlaybackPaused(position: _position, duration: _duration, audio: _currentAudio!));
    });
  }

  Future<void> play(AudioModel audio) async {
    if (_currentAudio != null && _currentAudio != audio) {
      await _audioPlayer.stop();
    }
    _currentAudio = audio;
    bloc.playingAudio = _currentAudio;
    await _audioPlayer.play(UrlSource(audio.audio.filePath));
    emit(AudioPlaybackPlaying(position: _position, duration: _duration, audio: _currentAudio!));
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    emit(AudioPlaybackPaused(position: _position, duration: _duration, audio: _currentAudio!));
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
    _position = position;
    if (state is AudioPlaybackPlaying) {
      emit(AudioPlaybackPlaying(position: _position, duration: _duration, audio: _currentAudio!));
    } else if (state is AudioPlaybackPaused) {
      emit(AudioPlaybackPaused(position: _position, duration: _duration, audio: _currentAudio!));
    }
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    _position = Duration.zero;
    emit(AudioPlaybackPaused(position: _position, duration: _duration, audio: _currentAudio!));
  }
}
