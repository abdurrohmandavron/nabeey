import 'package:flutter_bloc/flutter_bloc.dart' show Emitter;
import 'package:nabeey/data/repositories/audio_repository.dart';

import '../base/base_bloc.dart';
import '../../models/audio_model.dart';

import 'audio_event.dart';
import 'audio_state.dart';

class AudioBloc extends BaseBloc<AudioEvent, AudioState> {
  final AudioRepository audioRepository;

  AudioModel? playingAudio;

  AudioBloc(this.audioRepository) : super(AudioLoading()) {
    on<LoadAudios>((LoadAudios event, Emitter<AudioState> emit) async {
      try {
        final audios = await audioRepository.getAudios();
        emit(AudioLoaded(audios));
      } catch (e) {
        handleError(emit, e);
      }
    });
  }
}
