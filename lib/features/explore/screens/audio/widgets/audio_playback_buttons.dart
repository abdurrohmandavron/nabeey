import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:nabeey/utils/constants/colors.dart';
import 'package:nabeey/features/explore/models/audio_model.dart';

import '../../../blocs/audio/audio_bloc.dart';

class AudioPlaybackButtons extends StatelessWidget {
  const AudioPlaybackButtons({
    super.key,
    required this.audio,
    required this.state,
    required this.controller,
  });

  final AudioModel audio;
  final AudioState state;
  final AudioBloc controller;

  @override
  Widget build(BuildContext context) {
    Duration duration = state.duration;
    Duration position = state.position;
    bool isPlaying = state is AudioPlaying;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Feather.skip_back, size: ADSizes.iconMd),
          onPressed: () => controller.add(AudioSeek((position.inSeconds - 5).clamp(0, duration.inSeconds))),
        ),
        IconButton(
          onPressed: () => isPlaying ? controller.add(AudioPause()) : controller.add(AudioPlay(audio)),
          icon: Icon(isPlaying ? Icons.pause_circle : Icons.play_circle, size: 55, color: ADColors.primary),
        ),
        IconButton(
          icon: const Icon(Feather.skip_forward, size: ADSizes.iconMd),
          onPressed: () => controller.add(AudioSeek((position.inSeconds + 5).clamp(0, duration.inSeconds))),
        ),
      ],
    );
  }
}
