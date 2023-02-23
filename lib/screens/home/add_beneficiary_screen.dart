import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:rehab_care/config/validator.dart';
import 'package:rehab_care/screens/dialogs.dart';
import 'package:rehab_care/screens/home/model/image_process.dart';
import 'package:rehab_care/widgets/widgets_export.dart';

import '../../config/config_export.dart';
import '../authentication/authentication_export.dart';
import '../screens_export.dart';
import 'home_export.dart';
import 'model/model_export.dart';

class AddBeneficiaryScreen extends StatefulWidget {
  static const String routeName = "/addBeneficiary";
  final List<Major> major;

  const AddBeneficiaryScreen({Key? key, required this.major}) : super(key: key);

  @override
  State<AddBeneficiaryScreen> createState() => _AddBeneficiaryScreenState();
}

class _AddBeneficiaryScreenState extends State<AddBeneficiaryScreen> {
  Image personalPhoto = Image.asset(AppAssets.person2);
  Attachment? attachment;
  TextEditingController beneficiaryName = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController medicalNotes = TextEditingController();
  String id = "";
  bool datePicked = false;
  bool medical = false;
  bool able = true;
  late DatePickerTheme datePickerTheme;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    datePickerTheme = DatePickerTheme(
        backgroundColor: Theme.of(context).cardColor,
        itemStyle:
            TextStyle(color: Theme.of(context).textTheme.bodyText2?.color),
        cancelStyle:
            TextStyle(color: Theme.of(context).textTheme.bodyText2?.color),
        doneStyle: TextStyle(color: Theme.of(context).primaryColor));
    LocaleType datePickerLocale =
        (Localizations.localeOf(context).languageCode == "en"
            ? LocaleType.en
            : LocaleType.ar);
    return WillPopScope(
      onWillPop: () async {
        attachments.clear();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).add_ben),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(25),
          constraints: const BoxConstraints.expand(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet<int>(
                              context: context,
                              builder: (context) => imageModal(context))
                          .then((res) async {
                        if (res != null) {
                          if (res == 0) {
                            attachment = null;
                            setState(() {
                              personalPhoto = Image.asset(AppAssets.person2);
                            });
                          }
                          if (res == 2) {
                            FilePickerResult? res = await FilePicker.platform
                                .pickFiles(
                                    type: FileType.image, allowMultiple: false);
                            if (res != null) {
                              attachment = Attachment(
                                  file: await ImageProcess.setImage(
                                      File(res.files[0].path ?? " ")),
                                  name: "name");
                              setState(() {
                                personalPhoto = Image.file(
                                  attachment?.file ?? File("nn"),
                                  fit: BoxFit.cover,
                                  width: 200,
                                  height: 200,
                                );
                              });
                            }
                          }
                        }
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(250),
                        child: personalPhoto,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      S.of(context).image_tutorial,
                      textScaleFactor: 1,
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  TextFormField(
                    controller: beneficiaryName,
                    decoration: InputDecoration(
                      hintText: S.of(context).ben_name,
                    ),
                    validator: (data) {
                      if (!Validator.checkName(data ?? " ")) {
                        return "${S.of(context).ben_name} ${S.of(context).notValid}";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: date,
                    onTap: () {
                      DatePicker.showDatePicker(context,
                              theme: datePickerTheme, locale: datePickerLocale)
                          .then((value) {
                        String day = value?.day.toString() ?? " ";
                        String month = value?.month.toString() ?? " ";
                        String year = value?.year.toString() ?? " ";
                        if (day != " " && month != " " && year != " ") {
                          date =
                              TextEditingController(text: "$day/$month/$year");
                        }
                        datePicked = true;
                        setState(() {});
                      });
                    },
                    validator: (data) {
                      if (!datePicked) {
                        return "${S.of(context).dob} ${S.of(context).notValid}";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: S.of(context).dob,
                        border: Theme.of(context)
                            .inputDecorationTheme
                            .enabledBorder,
                        enabledBorder: Theme.of(context)
                            .inputDecorationTheme
                            .enabledBorder,
                        disabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
                    readOnly: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: medicalNotes,
                    decoration: InputDecoration(hintText: S.of(context).notes),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       S.of(context).attach_medical_reports,
                  //       textScaleFactor: 0.8,
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  // InkWell(
                  //   borderRadius: BorderRadius.circular(50),
                  //   onTap: () {
                  //     Navigator.pushNamed(context, AttachmentScreen.routeName);
                  //   },
                  //   child: Container(
                  //     width: 35,
                  //     height: 35,
                  //     alignment: Alignment.center,
                  //     decoration: BoxDecoration(
                  //         color: blueColor,
                  //         borderRadius: BorderRadius.circular(50)),
                  //     child: const Icon(
                  //       Icons.file_upload_outlined,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 25,
                  ),
                  BlocConsumer<HomeBloc, HomeState>(
                    listener: (context, state) {
                      if (state is ChildrenParentAddState) {
                        killLoading(context, false);
                        myCustomShowSnackBarText(
                            context, S.of(context).added_ben);
                        context.read<HomeBloc>().add(ChildrenParentGetEvent(
                            context.read<AuthBloc>().state.myUserLogin));
                        Navigator.pushNamed(context, PayNowScreen.routeName,
                            arguments: PayNowScreen(
                                childrenParent: state.newChildrenParent,
                                isEditing: true));
                      }
                      if (state is ChildrenParentErrorState) {
                        killLoading(context, true,
                            error: S.of(context).network_error);
                        able = true;
                      }
                    },
                    builder: (context, state) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          setState(() {});
                          FormState? formData = key.currentState;
                          if (formData!.validate() && able) {
                            showLoadingDialog(context);
                            able = false;
                            ChildrenParent childrenParent =
                                ChildrenParent().copyWith(
                              childName: beneficiaryName.text.toString(),
                              age: date.text.toString(),
                            );

                            context.read<HomeBloc>().add(ChildrenParentAddEvent(
                                childrenParent,
                                context.read<AuthBloc>().state.myUserInfo,
                                photo: attachment?.file,
                                notes: medicalNotes.text.trim()));
                          }
                          // print(attachment);
                          setState(() {});
                        },
                        child: Container(
                          width: size.width,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: blueColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            S.of(context).pay_now,
                            textScaleFactor: 1,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
