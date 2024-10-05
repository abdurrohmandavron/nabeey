import 'package:nabeey/features/explore/blocs/base/base_bloc.dart';
import 'package:nabeey/features/explore/models/audio_model.dart';

abstract class AudioState extends BaseState {
  const AudioState();

  @override
  List<Object> get props => [];
}

class AudioLoading extends AudioState {}

class AudioLoaded extends AudioState {
  final List<AudioModel> audios;

  const AudioLoaded(this.audios);

  @override
  List<Object> get props => [audios];

  @override
  String toString() => 'AudioLoaded { Audios: $audios }';
}

class AudioEmpty extends AudioState {}

class AudioError extends AudioState {
  final String message;

  const AudioError(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'AudioError { message: $message }';
}
