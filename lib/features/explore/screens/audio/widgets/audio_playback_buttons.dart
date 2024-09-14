import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:nabeey/utils/constants/colors.dart';
import 'package:nabeey/features/explore/models/audio_model.dart';
import 'package:nabeey/features/explore/cubits/audio/audio_playback_cubit.dart';

class AudioPlaybackButtons extends StatelessWidget {
  const AudioPlaybackButtons({
    super.key,
    required this.audio,
    required this.position,
    required this.duration,
    required this.isPlaying,
    required this.controller,
  });

  final bool isPlaying;
  final AudioModel audio;
  final Duration position;
  final Duration duration;
  final AudioPlaybackCubit controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Feather.skip_back, size: ADSizes.iconMd),
          onPressed: () => controller.seek(Duration(seconds: (position.inSeconds - 5).clamp(0, duration.inSeconds))),
        ),
        IconButton(
          onPressed: () => isPlaying ? controller.pause() : controller.play(audio),
          icon: Icon(isPlaying ? Icons.pause_circle : Icons.play_circle, size: 55, color: ADColors.primary),
        ),
        IconButton(
          icon: const Icon(Feather.skip_forward, size: ADSizes.iconMd),
          onPressed: () => controller.seek(Duration(seconds: (position.inSeconds + 5).clamp(0, duration.inSeconds))),
        ),
      ],
    );
  }
}
