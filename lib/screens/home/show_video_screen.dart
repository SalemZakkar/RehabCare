import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rehab_care/screens/home/model/model_export.dart';
import 'package:video_player/video_player.dart';

import '../../config/config_export.dart';

class ShowVideoScreen extends StatefulWidget {
  final VideoModel videoModel;

  const ShowVideoScreen({Key? key, required this.videoModel}) : super(key: key);

  @override
  State<ShowVideoScreen> createState() => _ShowVideoScreenState();
}

class _ShowVideoScreenState extends State<ShowVideoScreen> {
  late VideoPlayerController controller;
  bool isPlaying = false;
  bool pressed = false;
  List<DeviceOrientation> defOrientation = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ];
  List<DeviceOrientation> fullScreenOrient = [
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ];

  @override
  void initState() {
    loadVideoPlayer();
    super.initState();
  }

  loadVideoPlayer() {
    // controller = VideoPlayerController.network(
    //     'https://www.fluttercampus.com/video.mp4');
    controller =
        VideoPlayerController.network(widget.videoModel.urlVideo.toString());

    controller.addListener(() {
      setState(() {});
    });
    controller.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  late bool landscape;

  @override
  Widget build(BuildContext context) {
    landscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return WillPopScope(
      onWillPop: () async {
        SystemChrome.setPreferredOrientations(defOrientation);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);
        return true;
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          appBar: (landscape
              ? null
              : AppBar(
                  title: Text(S.of(context).video),
                  centerTitle: true,
                )),
          body: InkWell(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            onTap: () {
              if (pressed) {
                SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (isPlaying == false)
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 35.0, right: 35.0),
                          child: GestureDetector(
                            onTap: () {
                              isPlaying = true;
                              setState(() {});
                              controller.play();
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Stack(
                                children: [
                                  Image.network(
                                    widget.videoModel.coverVideo.toString(),
                                    height: 200.0,
                                    width: double.maxFinite,
                                    fit: BoxFit.cover,
                                  ),
                                  Column(
                                    children: const [
                                      SizedBox(height: 60.0),
                                      Center(
                                          child: Icon(
                                        Icons.play_arrow,
                                        size: 80.0,
                                        color: yellowColor,
                                      )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (isPlaying == true)
                    Column(
                      children: [
                        AspectRatio(
                          aspectRatio: (landscape
                              ? (MediaQuery.of(context).size.width /
                                  (MediaQuery.of(context).size.height))
                              : controller.value.aspectRatio),
                          child: VideoPlayer(controller),
                        ),
                        VideoProgressIndicator(
                          controller,
                          allowScrubbing: true,
                          colors: const VideoProgressColors(
                            backgroundColor: blueColor,
                            playedColor: yellowColor,
                            bufferedColor: Colors.grey,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  if (controller.value.isPlaying) {
                                    controller.pause();
                                  } else {
                                    controller.play();
                                  }

                                  setState(() {});
                                },
                                icon: Icon(controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow)),
                            IconButton(
                                onPressed: () {
                                  controller.seekTo(const Duration(seconds: 0));
                                  setState(() {});
                                },
                                icon: const Icon(Icons.stop)),
                            const Expanded(child: SizedBox()),
                            Text(
                                controller.value.position.inMinutes.toString()),
                            const Text(':'),
                            Text(
                                controller.value.position.inSeconds.toString()),
                            const Text(' / '),
                            Text(
                                controller.value.duration.inMinutes.toString()),
                            const Text(':'),
                            Text(
                                controller.value.duration.inSeconds.toString()),
                            const SizedBox(width: 20.0),
                            InkWell(
                                onTap: () {
                                  if (!pressed) {
                                    SystemChrome.setPreferredOrientations(
                                        fullScreenOrient);
                                    SystemChrome.setEnabledSystemUIMode(
                                        SystemUiMode.leanBack);
                                    pressed = true;
                                  } else {
                                    SystemChrome.setEnabledSystemUIMode(
                                        SystemUiMode.manual,
                                        overlays: SystemUiOverlay.values);
                                    SystemChrome.setPreferredOrientations(
                                        defOrientation);
                                    pressed = false;
                                  }
                                },
                                child: const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Icon(Icons.fullscreen))),
                            const SizedBox(width: 20.0),
                          ],
                        ),
                      ],
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.videoModel.titleVideo.toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.videoModel.fullText.toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            widget.videoModel.subDate
                                .toString()
                                .split(" ")
                                .first,
                            textScaleFactor: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
