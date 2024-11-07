import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/utils/constants/colors.dart';
import 'package:nabeey/features/explore/models/audio_model.dart';
import 'package:nabeey/features/explore/blocs/audio/audio_bloc.dart';
import 'package:nabeey/features/explore/screens/audio/widgets/audio_playback_buttons.dart';
import 'package:nabeey/features/explore/screens/audio/widgets/audio_position_duration.dart';

class AudioItem extends StatelessWidget {
  const AudioItem({super.key, required this.audio});

  final AudioModel audio;

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<AudioBloc>(context);

    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        Duration position = Duration.zero;
        Duration duration = Duration.zero;

        if (state is AudioPlaying || state is AudioPaused) {
          position = state.position;
          duration = state.duration;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Slider(
              min: 0.0,
              activeColor: ADColors.primary,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) => controller.add(AudioSeek(value.toInt())),
            ),
            AudioPositionDuration(position: position, duration: duration),
            AudioPlaybackButtons(audio: audio, controller: controller, state: state),
          ],
        );
      },
    );
  }
}
