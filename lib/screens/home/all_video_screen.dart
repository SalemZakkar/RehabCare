import 'package:flutter/material.dart';
import 'package:rehab_care/screens/dialogs.dart';
import 'package:rehab_care/screens/home/model/model_export.dart';

import '../../config/config_export.dart';
import '../screens_export.dart';
import 'home_export.dart';

class AllVideoScreen extends StatefulWidget {
  final String childId;
  final String majorId;

  const AllVideoScreen({Key? key, required this.childId, required this.majorId})
      : super(key: key);
  static const String routeName = 'all_video_screen';

  @override
  State<AllVideoScreen> createState() => _AllVideoScreenState();
}

class _AllVideoScreenState extends State<AllVideoScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<HomeBloc>()
        .add(GetAllVideoEvent(widget.childId, widget.majorId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(S.of(context).video),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeError) {
            return noNetwork(context, () {
              context
                  .read<HomeBloc>()
                  .add(GetAllVideoEvent(widget.childId, widget.majorId));
            });
          }
          if (state is GetAllVideoState && state.isLoading == false) {
            if (state.listVideoModel.isEmpty) {
              return noData(context);
            } else {
              return ListView.builder(
                itemCount: state.listVideoModel.length,
                itemBuilder: (context, index) {
                  VideoModel videoModel = state.listVideoModel[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ShowVideoScreen(videoModel: videoModel)));
                            debugPrint('show video');
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Stack(
                              children: [
                                Image.network(
                                  videoModel.coverVideo.toString(),
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
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              videoModel.titleVideo.toString(),
                              textAlign: TextAlign.center,
                            )),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                videoModel.partText.toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  );
                },
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
