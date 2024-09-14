import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/utils/exceptions/exceptions.dart';
import 'package:nabeey/data/repositories/audio_repository.dart';
import 'package:nabeey/features/explore/models/audio_model.dart';

import 'audio_event.dart';
import 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final AudioRepositoryImpl audioRepository = AudioRepositoryImpl();

  AudioModel? playingAudio;

  AudioBloc() : super(AudioLoading()) {
    on<LoadAudios>((LoadAudios event, Emitter<AudioState> emit) async {
      try {
        final audios = await audioRepository.getAudios();
        emit(AudioLoaded(audios));
      } on SocketException {
        emit(const AudioError("Server bilan bog'lanib bo'lmadi."));
      } catch (e) {
        ADException(e);
        emit(AudioError('AudioError: $e'));
      }
    });
  }
}
