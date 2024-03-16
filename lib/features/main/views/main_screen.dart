// ignore_for_file: deprecated_member_use

import 'package:blue_tube/common/constants/sizes.dart';
import 'package:blue_tube/common/utils/back_handler_button.dart';
import 'package:blue_tube/features/main/models/video_model.dart';
import 'package:blue_tube/features/main/repositories/blue_tube_repository.dart';
import 'package:blue_tube/features/main/widgets/blue_tube_player.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String routeName = '/main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  /// 뒤로가기 Action 처리
  BackHandlerButton? backHandlerButton;

  @override
  void initState() {
    super.initState();

    backHandlerButton = BackHandlerButton(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (backHandlerButton != null) {
          return backHandlerButton!.onWillPop();
        }

        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            'BlueTube',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
        body: Container(
          margin: const EdgeInsets.all(Sizes.size20),
          child: FutureBuilder<List<VideoModel>>(
            future: BlueTubeRepository.getVideos(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size16,
                    ),
                  ),
                );
              }

              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {});
                },
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: snapshot.data!
                      .map((data) => BlueTubePlayer(videoModel: data))
                      .toList(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
