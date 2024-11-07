import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart' hide AudioEvent;
import 'package:nabeey/features/explore/models/audio_model.dart';
import 'package:nabeey/features/explore/blocs/base/base_bloc.dart';

part 'audio_state.dart';

part 'audio_event.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  AudioBloc(this.bloc) : super(AudioInitial()) {
    _audioPlayer = AudioPlayer();

    on<AudioInit>(_registerListeners);

    on<AudioPlay>(_audioPlay);
    on<AudioChangePosition>(_audioChangePosition);
    on<AudioChangeDuration>(_audioChangeDuration);
    on<AudioPause>(_audioPause);
    on<AudioResume>(_audioResume);
    on<AudioSeek>(_audioSeek);
    on<AudioStop>(_audioStop);

    add(AudioInit());
  }

  AudioModel? _currentAudio;
  late AudioPlayer _audioPlayer;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  BaseBloc<AudioModel> bloc;

  void _registerListeners(AudioInit event, Emitter<AudioState> emit) {
    _audioPlayer.onPositionChanged.listen((position) {
      add(AudioChangePosition(position.inSeconds));
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      add(AudioChangeDuration(duration.inSeconds));
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      add(AudioStop());
    });
  }

  Future<void> _audioPlay(AudioPlay event, Emitter<AudioState> emit) async {
    if (_currentAudio != null && _currentAudio != event.audio) {
      await _audioPlayer.stop();
    }
    _currentAudio = event.audio;
    bloc.playingAudio = _currentAudio;
    await _audioPlayer.play(UrlSource(event.audio.audio.filePath));
    emit(AudioPlaying(position: _position, duration: _duration, audio: _currentAudio!));
  }

  Future<void> _audioChangePosition(AudioChangePosition event, Emitter<AudioState> emit) async {
    _position = Duration(seconds: event.position);
    if (bloc.playingAudio != _currentAudio) {
      add(AudioPause());
    }
    if (state is AudioPlaying) {
      emit(AudioPlaying(position: _position, duration: _duration, audio: _currentAudio!));
    } else if (state is AudioPaused) {
      emit(AudioPaused(position: _position, duration: _duration, audio: _currentAudio!));
    }
  }

  Future<void> _audioChangeDuration(AudioChangeDuration event, Emitter<AudioState> emit) async {
    _duration = Duration(seconds: event.duration);
    if (state is AudioPlaying) {
      emit(AudioPlaying(position: _position, duration: _duration, audio: _currentAudio!));
    } else if (state is AudioPaused) {
      emit(AudioPaused(position: _position, duration: _duration, audio: _currentAudio!));
    }
  }

  Future<void> _audioResume(AudioResume event, Emitter<AudioState> emit) async {
    await _audioPlayer.resume();
    emit(AudioPlaying(position: _position, duration: _duration, audio: _currentAudio!));
  }

  Future<void> _audioPause(AudioPause event, Emitter<AudioState> emit) async {
    await _audioPlayer.pause();
    emit(AudioPaused(position: _position, duration: _duration, audio: _currentAudio!));
  }

  Future<void> _audioSeek(AudioSeek event, Emitter<AudioState> emit) async {
    await _audioPlayer.seek(Duration(seconds: event.position));
    _position = Duration(seconds: event.position);
    if (state is AudioPlaying) {
      emit(AudioPlaying(position: _position, duration: _duration, audio: _currentAudio!));
    } else if (state is AudioPaused) {
      emit(AudioPaused(position: _position, duration: _duration, audio: _currentAudio!));
    }
  }

  Future<void> _audioStop(AudioStop event, Emitter<AudioState> emit) async {
    await _audioPlayer.stop();
    _position = Duration.zero;
    emit(AudioPaused(position: _position, duration: _duration, audio: _currentAudio!));
  }
}
