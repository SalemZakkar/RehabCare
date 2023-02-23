import 'package:flutter/material.dart';
import 'package:rehab_care/screens/dialogs.dart';
import 'package:rehab_care/screens/medical_file/medical_file_export.dart';
import 'package:rehab_care/widgets/widgets_export.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/config_export.dart';
import '../home/model/model_export.dart';
import '../screens_export.dart';

class MedicalFileScreen extends StatefulWidget {
  static const String routeName = "/medicalFileScreen";

  const MedicalFileScreen({Key? key}) : super(key: key);

  @override
  State<MedicalFileScreen> createState() => _MedicalFileScreenState();
}

class _MedicalFileScreenState extends State<MedicalFileScreen> {
  String selected = "";
  bool check = true;
  int id = -1;
  String url = "";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider<MedicalFileBloc>(
      create: (context) => MedicalFileBloc(),
      child: BlocBuilder<MedicalFileBloc, MedicalFileState>(
        builder: (context, state) {
          if (state is MedicalEmpty) {
            if (check) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                myCustomShowSnackBarText(context, S.of(context).noMedical);
              });
              check = false;
            }
          }
          if (state is MedicalWait) {
            check = true;
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MedicalFail) {
            check = true;
            return noNetwork(context, () {
              context.read<MedicalFileBloc>().add(MedicalReset());
            });
          } else {
            if (state is MedicalFileGetState) {
              url = state.medicalFile.medicalReport ?? "";
              launchUrl(Uri.parse("https://docs.google.com/viewer?url=$url"));
              context.read<MedicalFileBloc>().add(MedicalReset());
            }
            return Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              constraints: const BoxConstraints.expand(),
              padding: const EdgeInsets.all(15),
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed<ChildrenParent>(
                                SelectBeneficiaryScreen.routeName)
                            .then((value) {
                          if (value != null) {
                            setState(() {
                              selected = value.childName ?? " ";
                              id = int.parse(value.childId ?? "-1");
                            });
                          }
                        });
                      },
                      child: SizedBox(
                        width: size.width,
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5, top: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).select_ben,
                                    textScaleFactor: 1.2,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    selected,
                                    textScaleFactor: 0.9,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.color),
                                  )
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.arrow_forward_sharp,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: 0.7,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: size.height * 0.15,
                    ),
                    Image.asset(AppAssets.download),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    InkWell(
                      onTap: () {
                        if (selected != "" && id != -1) {
                          context
                              .read<MedicalFileBloc>()
                              .add(MedicalGetEvent(id: id.toString()));
                        } else {
                          myCustomShowSnackBarText(
                              context, S.of(context).please_select_ben);
                        }
                      },
                      child: Container(
                        width: size.width * 0.7,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: blueColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          S.of(context).view_med,
                          textScaleFactor: 1.2,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
