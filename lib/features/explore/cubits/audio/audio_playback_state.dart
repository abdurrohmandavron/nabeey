import 'package:equatable/equatable.dart';
import 'package:nabeey/features/explore/models/audio_model.dart';

abstract class AudioPlaybackState extends Equatable {
  const AudioPlaybackState({
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

class AudioPlaybackInitial extends AudioPlaybackState {
  AudioPlaybackInitial() : super(position: Duration.zero, duration: Duration.zero, audio: AudioModel.empty());
}

class AudioPlaybackPlaying extends AudioPlaybackState {
  const AudioPlaybackPlaying({required super.position, required super.duration, required super.audio});
}

class AudioPlaybackPaused extends AudioPlaybackState {
  const AudioPlaybackPaused({required super.position, required super.duration, required super.audio});
}
