import 'package:flutter/material.dart';
import 'package:rehab_care/screens/dialogs.dart';
import 'package:rehab_care/screens/screens_export.dart';

import '../../config/config_export.dart';
import 'home_export.dart';
import 'model/model_export.dart';

/// api name all_assessment_video
class TherapeuticSessionsScreen extends StatefulWidget {
  const TherapeuticSessionsScreen(
      {Key? key, required this.childId, required this.majorId})
      : super(key: key);
  static const String routeName = '/therapeutic_sessions_screen';
  final String childId;
  final String majorId;

  @override
  State<TherapeuticSessionsScreen> createState() =>
      _TherapeuticSessionsScreenState();
}

class _TherapeuticSessionsScreenState extends State<TherapeuticSessionsScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<HomeBloc>()
        .add(GetTherapeuticSessionsEvent(widget.childId, widget.majorId));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(S.of(context).treatment_sessions),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is UploadAssessmentVideoState && state.isDone == true) {
            context.read<HomeBloc>().add(
                GetTherapeuticSessionsEvent(widget.childId, widget.majorId));
          }
          if (state is HomeError) {
            return noNetwork(context, () {
              context.read<HomeBloc>().add(
                  GetTherapeuticSessionsEvent(widget.childId, widget.majorId));
            });
          }
          if (state is GetTherapeuticSessionsState &&
              state.isLoading == false) {
            if (state.listAllAssessmentVideo.isEmpty) {
              return noData(context);
            } else {
              return ListView.builder(
                itemCount: state.listAllAssessmentVideo.length,
                itemBuilder: (context, index) {
                  AllAssessmentVideo assessmentVideo =
                      state.listAllAssessmentVideo[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SingleAssessmentVideo(
                                    assessmentVideo: assessmentVideo,
                                  ),
                                ));
                          },
                          child: Image.asset(AppAssets.video),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              assessmentVideo.title.toString(),
                              textAlign: TextAlign.center,
                            )),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                assessmentVideo.description.toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15.0),
                        Container(
                          height: 1.0,
                          width: double.maxFinite,
                          color: blueColor,
                        ),
                        const SizedBox(height: 15.0),
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
