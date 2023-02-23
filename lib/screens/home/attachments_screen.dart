import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rehab_care/screens/dialogs.dart';
import 'package:rehab_care/screens/home/bloc/treat_plans_bloc/treat_plans_bloc.dart';
import 'package:rehab_care/screens/home/home_export.dart';
import 'package:rehab_care/screens/home/widget/attachment_card.dart';

import '../../config/config_export.dart';
import 'model/model_export.dart';

class AttachmentScreen extends StatefulWidget {
  static const String routeName = "/medicalAttachments";
  final String childId;

  const AttachmentScreen({Key? key, required this.childId}) : super(key: key);

  @override
  State<AttachmentScreen> createState() => _AttachmentScreenState();
}

class _AttachmentScreenState extends State<AttachmentScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).attachment),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is AttachmentInitial) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              setState(() {});
            });
          }
          if (state is DeleteAttachmentState) {
            //     print(state.name);
            //     for(int i = 0 ;i < attachments.length ; i ++)
            //       {
            //         print(attachments[i].name);
            // }
            // List<Attachment> temp = attachments;
            //
            // attachments = temp;
            //     print(attachments.length);

          }
          return Container(
            width: size.width,
            height: size.height,
            alignment: Alignment.topCenter,
            child: (attachments.isEmpty
                ? noData(context)
                : ListView.builder(
                    itemCount: attachments.length + 2,
                    itemBuilder: (context, index) {
                      if (index == attachments.length) {
                        return const SizedBox(
                          height: 30,
                        );
                      }
                      if (index == attachments.length + 1) {
                        return BlocProvider(
                            create: (context) => TreatPlansBloc(),
                            child: sButton(context, widget.childId));
                      }
                      return AttachmentCard(
                        attachment: attachments[index],
                        index: index,
                      );
                    },
                  )),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FilePickerResult? filePickerResult = await FilePicker.platform
              .pickFiles(
                  allowedExtensions: ["jpg", "png", "pdf", "jpeg"],
                  allowMultiple: true,
                  type: FileType.custom,
                  dialogTitle: S.of(context).attach_medical_reports);
          if (filePickerResult != null) {
            for (PlatformFile f in filePickerResult.files) {
              attachments
                  .add(Attachment(file: File(f.path ?? " "), name: f.name));
            }
            setState(() {});
          }
          setState(() {});
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

Widget sButton(BuildContext context, String childId) {
  return BlocBuilder<TreatPlansBloc, TreatPlansState>(
    builder: (context, state) {
      if (state is AddReportDone) {
        if (state.res == '1') {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            killLoading(context, true, error: S.of(context).success);
            attachments.clear();
            Navigator.pop(context);
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            killLoading(context, true, error: S.of(context).temp_error);
            attachments.clear();
            Navigator.pop(context);
          });
        }
      }
      if (state is TreatError) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          killLoading(context, true, error: S.current.network_error);
        });
      }
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        color: Colors.transparent,
        alignment: Alignment.center,
        child: InkWell(
          onTap: () {
            showLoadingDialog(context);
            context
                .read<TreatPlansBloc>()
                .add(AddReport(childId: childId, file: attachments[0].file));
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).textTheme.caption?.color),
            alignment: Alignment.center,
            child: Text(
              S.of(context).save,
              textScaleFactor: 1,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    },
  );
}
