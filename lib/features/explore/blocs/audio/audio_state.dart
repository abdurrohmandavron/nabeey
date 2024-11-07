
part of 'audio_bloc.dart';

abstract class AudioState extends Equatable {
  const AudioState({
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

class AudioInitial extends AudioState {
  AudioInitial() : super(position: Duration.zero, duration: Duration.zero, audio: AudioModel.empty());
}

class AudioPlaying extends AudioState {
  const AudioPlaying({required super.position, required super.duration, required super.audio});
}

class AudioPaused extends AudioState {
  const AudioPaused({required super.position, required super.duration, required super.audio});
}
