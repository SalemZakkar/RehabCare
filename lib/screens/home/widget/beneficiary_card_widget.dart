import 'package:flutter/material.dart';

import '../../../config/config_export.dart';
import '../../authentication/authentication_export.dart';
import '../../dialogs.dart';
import '../../screens_export.dart';
import '../home_export.dart';
import '../model/model_export.dart';
import 'widget_export.dart';

class BeneficiaryWidget extends StatefulWidget {
  final ChildrenParent childrenParentParent;
  final bool flag;

  const BeneficiaryWidget(
      {Key? key, required this.childrenParentParent, required this.flag})
      : super(key: key);

  @override
  State<BeneficiaryWidget> createState() => _BeneficiaryWidgetState();
}

class _BeneficiaryWidgetState extends State<BeneficiaryWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //print(widget.childrenParentParent.photo ?? "");
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        if (widget.flag == false) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => ViewBeneficiary(
                    childrenParent: widget.childrenParentParent,
                  )));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          padding: const EdgeInsets.all(10),
          width: size.width,
          height: 110,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(15)),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is ChildrenParentDeleteState) {
                context.read<HomeBloc>().add(ChildrenParentGetEvent(
                    context.read<AuthBloc>().state.myUserLogin));
                context.read<HomeBloc>().add(MajorGetEvent());

                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  if (widget.flag) {
                    Navigator.pushNamedAndRemoveUntil(context,
                        NavigationBarScreen.routeName, (route) => false);
                  }
                });
              }
              // if (state is ChildrenParentErrorState) {
              //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              //     if (dialogRunning) {
              //       Navigator.pop(context);
              //       dialogRunning = false;
              //     }
              //     //  Navigator.of(context , rootNavigator: true).pop();
              //
              //     // myCustomShowSnackBarText(
              //     //     context, S.of(context).network_error);
              //   });
              // }
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  imageLead(
                    size,
                    true,
                    widget.childrenParentParent.photo,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.childrenParentParent.childName.toString(),
                        textScaleFactor: 0.8,
                        style: TextStyle(
                            color: Theme.of(context).textTheme.caption?.color),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.childrenParentParent.age.toString(),
                        textScaleFactor: 0.7,
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText2?.color),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, EditBeneficiaryScreen.routeName,
                          arguments: (widget.childrenParentParent));
                    },
                    child: SizedBox(
                      width: 60,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.edit,
                            size: 20,
                            color: blueColor,
                          ),
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          Text(
                            S.of(context).edit,
                            textScaleFactor: 0.9,
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      /// use flag to pop context or not (widget.flag) - bool
                      showModalBottomSheet(
                              context: context,
                              builder: (context) => confirmModal(context))
                          .then((value) {
                        if (value != null && value) {
                          showLoadingDialog(context);
                          context.read<HomeBloc>().add(
                              ChildrenParentDeleteEvent(
                                  widget.childrenParentParent,
                                  context.read<AuthBloc>().state.myUserInfo));
                        }
                      });
                    },
                    child: SizedBox(
                      width: 70,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.delete,
                            size: 20,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          Text(
                            S.of(context).delete,
                            textScaleFactor: 0.9,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
