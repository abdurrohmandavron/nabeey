import 'package:flutter/material.dart';
import 'package:nabeey/utils/constants/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatelessWidget {
  const VideoPlayer({super.key, required this.url, required this.play});

  final String url;
  final bool play;

  @override
  Widget build(BuildContext context) {
    final YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url)!,
      flags: YoutubePlayerFlags(autoPlay: play, mute: false, loop: false, forceHD: true),
    );

    return YoutubePlayer(
      width: double.infinity,
      controller: controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: ADColors.primary,
      progressColors: const ProgressBarColors(
        playedColor: ADColors.primary,
        handleColor: ADColors.primary,
      ),
    );
  }
}
