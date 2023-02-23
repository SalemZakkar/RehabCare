import 'package:flutter/material.dart';
import 'package:rehab_care/widgets/widgets_export.dart';

import '../../config/config_export.dart';
import '../screens_export.dart';
import 'model/model_export.dart';
import 'widget/widget_export.dart';

class ViewBeneficiary extends StatefulWidget {
  final ChildrenParent childrenParent;

  const ViewBeneficiary({Key? key, required this.childrenParent})
      : super(key: key);

  @override
  State<ViewBeneficiary> createState() => _ViewBeneficiaryState();
}

class _ViewBeneficiaryState extends State<ViewBeneficiary> {
  Major? major;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(S.of(context).beneficiaries),
        centerTitle: true,
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BeneficiaryWidget(
                childrenParentParent: widget.childrenParent,
                flag: true,
              ),
              InkWell(
                onTap: () async {
                  Major? majorRes = await getMedicalCase(context);
                  if (majorRes != null) {
                    major = majorRes;
                    setState(() {});
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        (major == null
                            ? S.of(context).medical_condition
                            : major?.name ?? ""),
                        textScaleFactor: 1,
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText2?.color),
                      ),
                      Icon(
                        Icons.arrow_forward_sharp,
                        color: Theme.of(context).dividerColor,
                      )
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      if (major != null) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => AllVideoScreen(
                                  childId:
                                      widget.childrenParent.childId.toString(),
                                  majorId: major!.id.toString(),
                                )));
                      } else {
                        myCustomShowSnackBarText(
                            context, S.of(context).please_select_major);
                      }
                    },
                    child: Container(
                      width: size.width * 0.498,
                      height: size.height * 0.25,
                      decoration:
                          BoxDecoration(color: Theme.of(context).cardColor),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppAssets.video),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            S.of(context).videos,
                            textScaleFactor: 1,
                            style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.caption?.color),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (major != null) {
                        Navigator.pushNamed(context, AllReviewsScreen.routeName,
                            arguments: AllReviewsScreen(
                              childId: widget.childrenParent.childId.toString(),
                              majorId: major!.id.toString(),
                            ));
                      } else {
                        myCustomShowSnackBarText(
                            context, S.of(context).please_select_major);
                      }
                    },
                    child: Container(
                      width: size.width * 0.498,
                      height: size.height * 0.25,
                      decoration:
                          BoxDecoration(color: Theme.of(context).cardColor),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppAssets.helpCenter),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            S.of(context).reviews,
                            textScaleFactor: 1,
                            style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.caption?.color),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      if (major != null) {
                        Navigator.pushNamed(
                            context, AllTreatingPlansScreen.routeName,
                            arguments: AllTreatingPlansScreen(
                                childId:
                                    widget.childrenParent.childId.toString(),
                                majorId: major!.id.toString()));
                      } else {
                        myCustomShowSnackBarText(
                            context, S.of(context).please_select_major);
                      }
                    },
                    child: Container(
                      width: size.width * 0.498,
                      height: size.height * 0.25,
                      decoration:
                          BoxDecoration(color: Theme.of(context).cardColor),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppAssets.treatment),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            S.of(context).treatment_plan,
                            textScaleFactor: 1,
                            style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.caption?.color),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (major != null) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                TherapeuticSessionsScreen(
                                  childId:
                                      widget.childrenParent.childId.toString(),
                                  majorId: major!.id.toString(),
                                )));
                      } else {
                        myCustomShowSnackBarText(
                            context, S.of(context).please_select_major);
                      }
                    },
                    child: Container(
                      width: size.width * 0.498,
                      height: size.height * 0.25,
                      decoration:
                          BoxDecoration(color: Theme.of(context).cardColor),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppAssets.treatmentSession),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            S.of(context).treatment_sessions,
                            textScaleFactor: 1,
                            style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.caption?.color),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "${S.of(context).sub_valid} ${widget.childrenParent.addedDate?.split(" ").first}",
                  textScaleFactor: 1,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, PayNowScreen.routeName,
                        arguments: PayNowScreen(
                            childrenParent: widget.childrenParent,
                            isEditing: true));
                  },
                  child: Container(
                    width: size.width * 0.5,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: blueColor),
                    child: Text(
                      S.of(context).renew_sub,
                      textScaleFactor: 1,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
