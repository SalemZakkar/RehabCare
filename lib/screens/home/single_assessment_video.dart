import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rehab_care/widgets/widgets_export.dart';
import 'package:video_player/video_player.dart';

import '../../config/config_export.dart';
import 'home_export.dart';
import 'model/model_export.dart';

class SingleAssessmentVideo extends StatefulWidget {
  const SingleAssessmentVideo({Key? key, required this.assessmentVideo})
      : super(key: key);
  final AllAssessmentVideo assessmentVideo;

  @override
  State<SingleAssessmentVideo> createState() => _SingleAssessmentVideoState();
}

class _SingleAssessmentVideoState extends State<SingleAssessmentVideo> {
  Attachment? attachment;
  FilePickerResult? resFilePicker;

  late VideoPlayerController controller;
  bool isPlaying = false;

  loadVideoPlayer() {
    File videoFile = File(resFilePicker!.files[0].path.toString());
    controller = VideoPlayerController.file(videoFile);

    controller.addListener(() {
      setState(() {});
    });
    controller.initialize().then((value) {
      controller.play();
      setState(() {});
    });
  }

  @override
  void dispose() {
    if (resFilePicker != null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<HomeBloc>().add(StopUploadingEvent());
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              context.read<HomeBloc>().add(StopUploadingEvent());
              Navigator.pop(context);
            },
          ),
          title: Text(S.of(context).treatment_sessions),
          centerTitle: true,
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is UploadDone) {
              Navigator.pop(context);
              myCustomShowSnackBarText(context, S.of(context).success);
            }
            if (state is UploadErrorState) {
              // Navigator.pop(context);
              myCustomShowSnackBarText(context, state.errorBody);
            }
            if (state is HomeError) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is GetTherapeuticSessionsState ||
                state is UploadAssessmentVideoState) {
              if (state is GetTherapeuticSessionsState ||
                  state is UploadAssessmentVideoState &&
                      state.isLoading == false) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20.0),
                        if (resFilePicker == null)
                          GestureDetector(
                            onTap: () async {
                              ///TODO UploadVideoPart 1
                              await FilePicker.platform.clearTemporaryFiles();
                              resFilePicker =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.video,
                                withReadStream: true,
                                allowCompression: false,
                                allowMultiple: false,
                                withData: true,
                              );
                              if (resFilePicker != null) {
                                setState(() {});
                                loadVideoPlayer();
                                debugPrint("get video");
                                debugPrint(
                                    resFilePicker?.files.first.path ?? "");
                              }
                            },
                            child: Column(
                              children: [
                                Image.asset(AppAssets.video),
                                const SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      S.of(context).choice_video,
                                      textAlign: TextAlign.center,
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        if (resFilePicker != null)
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: controller.value.aspectRatio,
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
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
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
                                          controller.seekTo(
                                              const Duration(seconds: 0));

                                          setState(() {});
                                        },
                                        icon: const Icon(Icons.stop)),
                                    const Expanded(child: SizedBox()),
                                    Text(controller.value.position.inMinutes
                                        .toString()),
                                    const Text(':'),
                                    Text(controller.value.position.inSeconds
                                        .toString()),
                                    const Text(' / '),
                                    Text(controller.value.duration.inMinutes
                                        .toString()),
                                    const Text(':'),
                                    Text(controller.value.duration.inSeconds
                                        .toString()),
                                    const SizedBox(width: 10.0),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              widget.assessmentVideo.title.toString(),
                              textAlign: TextAlign.center,
                            )),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.assessmentVideo.description.toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Text(
                        //         widget.assessmentVideo.status.toString(),
                        //         textAlign: TextAlign.center,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "${S.of(context).req_date} : ${widget.assessmentVideo.reqDate?.split(" ").first}",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${S.of(context).sub_date} : ${widget.assessmentVideo.subDate?.split(" ").first}",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () async {
                              debugPrint('send upload video');
                              if (resFilePicker == null) {
                                myCustomShowSnackBarText(
                                    context, S.of(context).please_choice_video);
                              } else {
                                ///TODO UploadVideoPart 2
                                controller.pause();
                                context.read<HomeBloc>().add(
                                    UploadAssessmentVideoEvent(
                                        File(resFilePicker!.files[0].path
                                            .toString()),
                                        widget.assessmentVideo.assessmentId
                                            .toString()));
                              }
                            },
                            child: Container(
                              width: double.maxFinite,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: blueColor),
                              child: Text(
                                S.of(context).upload_video,
                                textScaleFactor: 1,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40.0),
                      ],
                    ),
                  ),
                );
              } else if (state is UploadAssessmentVideoState &&
                  state.isLoading == true) {
                // String sending = filesize(state.sending);
                // String total = filesize(state.total);
                // return Center(
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       const CircularProgressIndicator(),
                //       const SizedBox(height: 20.0),
                //       Text(S.of(context).sending + sending),
                //       Text(S.of(context).total_upload + total),
                //       Text(
                //           S.of(context).presenting + state.presenting.toString()),
                //     ],
                //   ),
                // );
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).uploading,
                        textScaleFactor: 1,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CircularProgressIndicator(
                        backgroundColor: Theme.of(context).cardColor,
                        value: state.sending / state.total,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        state.presenting.toString(),
                        textScaleFactor: 1,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        S.of(context).keep_the_app_open,
                        textScaleFactor: 1,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        S.of(context).close_this_screen,
                        textScaleFactor: 1,
                      ),
                    ],
                  ),
                );
              } else {
                return const Text('12345');
              }
            } else {
              return const Center();
            }
          },
        ),
      ),
    );
  }
}
