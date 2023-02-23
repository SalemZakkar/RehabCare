import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:rehab_care/config/validator.dart';
import 'package:rehab_care/screens/dialogs.dart';
import 'package:rehab_care/screens/home/home_export.dart';
import 'package:rehab_care/screens/home/model/image_process.dart';

import '../../config/config_export.dart';
import '../screens_export.dart';
import 'model/model_export.dart';

class EditBeneficiaryScreen extends StatefulWidget {
  static const String routeName = "/edit_beneficiary";
  final ChildrenParent childrenParent;

  const EditBeneficiaryScreen({Key? key, required this.childrenParent})
      : super(key: key);

  @override
  State<EditBeneficiaryScreen> createState() => _EditBeneficiaryScreenState();
}

class _EditBeneficiaryScreenState extends State<EditBeneficiaryScreen> {
  late Widget personalPhoto;
  bool change = false;
  Attachment? attachment;
  TextEditingController beneficiaryName = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController medicalCase = TextEditingController();

  //bool datePicked = false;
  String id = "";
  bool newPhoto = false;
  int photoState = 0;
  bool medical = true;
  late DatePickerTheme datePickerTheme;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void initState() {
    beneficiaryName =
        TextEditingController(text: widget.childrenParent.childName);
    date = TextEditingController(text: widget.childrenParent.age);
    medicalCase = TextEditingController(text: widget.childrenParent.status);
    personalPhoto = getPhoto(widget.childrenParent.photo);
    super.initState();
  }

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
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).edit),
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
                                photoState = 1;
                                setState(() {
                                  change = true;
                                  personalPhoto =
                                      Image.asset(AppAssets.person2);
                                });
                                attachment = null;
                              }
                              if (res == 2) {
                                FilePickerResult? res =
                                    await FilePicker.platform.pickFiles(
                                        type: FileType.image,
                                        allowMultiple: false);
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
                                    change = true;
                                    photoState = 2;
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
                            child: getPhoto(change == false
                                ? widget.childrenParent.photo
                                : null),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
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
                                  theme: datePickerTheme,
                                  locale: datePickerLocale)
                              .then((value) {
                            String day = value?.day.toString() ?? " ";
                            String month = value?.month.toString() ?? " ";
                            String year = value?.year.toString() ?? " ";
                            if (day != " " && month != " " && year != " ") {
                              date = TextEditingController(
                                  text: "$day/$month/$year");
                            }
                            // datePicked = true;
                            setState(() {});
                          });
                        },
                        validator: (data) {
                          // if (!datePicked) {
                          //   return "${S.of(context).dob} ${S.of(context).notValid}";
                          // }
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
                      // TextFormField(
                      //   controller: medicalCase,
                      //   readOnly: true,
                      //   onTap: () async {
                      //     List<String> m =
                      //         (await getMedicalCase(context, state.listMajor));
                      //     String temp = m[0];
                      //     id = m[1];
                      //
                      //     if (temp != "") {
                      //       setState(() {
                      //         medicalCase = TextEditingController(text: temp);
                      //       });
                      //     }
                      //   },
                      //   decoration: InputDecoration(
                      //       hintText: S.of(context).medical_condition),
                      //   validator: (data) {
                      //     if (!medical) {
                      //       return "${S.of(context).medical_condition} ${S.of(context).notValid}";
                      //     }
                      //     return null;
                      //   },
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).attach_medical_reports,
                            textScaleFactor: 0.8,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          Navigator.pushNamed(
                              context, AttachmentScreen.routeName,
                              arguments: AttachmentScreen(
                                  childId:
                                      widget.childrenParent.childId ?? ""));
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: blueColor,
                              borderRadius: BorderRadius.circular(50)),
                          child: const Icon(
                            Icons.file_upload_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          setState(() {});
                          FormState? formData = key.currentState;
                          if (formData!.validate()) {
                            ChildrenParent old = widget.childrenParent;
                            ChildrenParent n = ChildrenParent(
                              childName: beneficiaryName.text,
                              age: (date.text),
                            );
                            showLoadingDialog(context);
                            context.read<HomeBloc>().add(
                                ChildrenParentUpdateEvent(
                                    oldChildrenParent: old,
                                    newChildrenParent: n,
                                    state: photoState,
                                    photo: attachment?.file));
                          }
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
                            S.of(context).save,
                            textScaleFactor: 1,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getPhoto(String? url) {
    if (url == null) {
      return personalPhoto;
    } else {
      return CachedNetworkImage(
        imageUrl: url,
        errorWidget: (a, b, c) => Icon(
          Icons.error,
          color: lightTheme.errorColor,
        ),
        placeholder: (a, b) => const Center(child: CircularProgressIndicator()),
        imageBuilder: (context, provider) {
          return Image(
            image: provider,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          );
        },
      );
    }
  }
}
