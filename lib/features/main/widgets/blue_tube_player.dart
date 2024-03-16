import 'package:blue_tube/common/constants/sizes.dart';
import 'package:blue_tube/features/main/models/video_model.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class BlueTubePlayer extends StatefulWidget {
  const BlueTubePlayer({
    super.key,
    required this.videoModel,
  });

  final VideoModel videoModel;

  @override
  State<BlueTubePlayer> createState() => _BlueTubePlayerState();
}

class _BlueTubePlayerState extends State<BlueTubePlayer> {
  YoutubePlayerController? tubeController;

  @override
  void initState() {
    super.initState();

    tubeController = YoutubePlayerController(
      initialVideoId: widget.videoModel.id,
      flags: const YoutubePlayerFlags(autoPlay: false),
    );
  }

  @override
  void dispose() {
    tubeController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        YoutubePlayer(
          controller: tubeController!,
          showVideoProgressIndicator: true,
        ),
        Container(
          margin: const EdgeInsets.all(Sizes.size20),
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size10),
          child: Text(
            widget.videoModel.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: Sizes.size16,
              fontWeight: FontWeight.w700
            ),
          ),
        ),
      ],
    );
  }
}
