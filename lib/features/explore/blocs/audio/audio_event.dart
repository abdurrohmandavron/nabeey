part of 'audio_bloc.dart';

abstract class AudioEvent extends Equatable {
  const AudioEvent();

  @override
  List<Object?> get props => [];
}

class AudioInit extends AudioEvent {}

class AudioPlay extends AudioEvent {
  final AudioModel audio;

  const AudioPlay(this.audio);

  @override
  List<Object?> get props => [audio];
}

class AudioResume extends AudioEvent {}

class AudioPause extends AudioEvent {}

class AudioSeek extends AudioEvent {
  final int position;

  const AudioSeek(this.position);

  @override
  List<Object?> get props => [position];
}

class AudioNext extends AudioEvent {}

class AudioPrevious extends AudioEvent {}

class AudioChangePosition extends AudioEvent {
  final int position;

  const AudioChangePosition(this.position);

  @override
  List<Object> get props => [position];
}

class AudioChangeDuration extends AudioEvent {
  final int duration;

  const AudioChangeDuration(this.duration);

  @override
  List<Object> get props => [duration];
}

class AudioStop extends AudioEvent {}
