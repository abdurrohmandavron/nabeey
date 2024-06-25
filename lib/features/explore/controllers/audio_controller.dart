import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nabeey/utils/exceptions/exceptions.dart';
import 'package:nabeey/data/repositories/audio_repository.dart';
import 'package:nabeey/features/explore/models/audio_model.dart';

class AudioController extends Bloc<AudioEvent, AudioState> {
  final AudioRepositoryImpl audioRepository = AudioRepositoryImpl();

  AudioModel? playingAudio;

  AudioController() : super(const AudioLoading()) {
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

abstract class AudioEvent extends Equatable {
  const AudioEvent();

  @override
  List<Object> get props => [];
}

class LoadAudios extends AudioEvent {
  const LoadAudios();

  @override
  String toString() => 'LoadAudios';
}

abstract class AudioState extends Equatable {
  const AudioState();

  @override
  List<Object> get props => [];
}

class AudioLoading extends AudioState {
  const AudioLoading();

  @override
  String toString() => 'AudioLoading';
}

class AudioLoaded extends AudioState {
  final List<AudioModel> audios;

  const AudioLoaded(this.audios);

  @override
  List<Object> get props => [audios];

  @override
  String toString() => 'AudioLoaded { Audios: $audios }';
}

class AudioEmpty extends AudioState {
  const AudioEmpty();

  @override
  String toString() => 'AudioEmpty';
}

class AudioError extends AudioState {
  final String message;

  const AudioError(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'AudioError { message: $message }';
}
