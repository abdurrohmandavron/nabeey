import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/utils/constants/colors.dart';
import 'package:nabeey/features/explore/models/audio_model.dart';
import 'package:nabeey/features/explore/cubits/audio/audio_playback_cubit.dart';
import 'package:nabeey/features/explore/cubits/audio/audio_playback_state.dart';
import 'package:nabeey/features/explore/screens/audio/widgets/audio_playback_buttons.dart';
import 'package:nabeey/features/explore/screens/audio/widgets/audio_position_duration.dart';

class AudioItem extends StatelessWidget {
  const AudioItem({super.key, required this.audio});

  final AudioModel audio;

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<AudioPlaybackCubit>(context);

    return BlocBuilder<AudioPlaybackCubit, AudioPlaybackState>(
      builder: (context, state) {
        Duration position = Duration.zero;
        Duration duration = Duration.zero;
        bool isPlaying = false;

        if (state is AudioPlaybackPlaying || state is AudioPlaybackPaused) {
          position = state.position;
          duration = state.duration;
          isPlaying = state is AudioPlaybackPlaying && state.audio == audio;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Slider(
              min: 0.0,
              activeColor: ADColors.primary,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) => controller.seek(Duration(seconds: value.toInt())),
            ),
            AudioPositionDuration(position: position, duration: duration),
            AudioPlaybackButtons(
              audio: audio,
              position: position,
              duration: duration,
              isPlaying: isPlaying,
              controller: controller,
            ),
          ],
        );
      },
    );
  }
}
