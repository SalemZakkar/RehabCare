import 'package:flutter/material.dart';
import 'package:rehab_care/screens/dialogs.dart';

import '../../config/config_export.dart';
import '../authentication/authentication_export.dart';
import '../authentication/models/models_export.dart';
import '../screens_export.dart';
import 'home_export.dart';
import 'model/model_export.dart';
import 'widget/widget_export.dart';

class PayNowScreen extends StatefulWidget {
  static const String routeName = "/cardInfo";
  final bool isEditing;
  final ChildrenParent childrenParent;

  const PayNowScreen(
      {Key? key, required this.childrenParent, required this.isEditing})
      : super(key: key);

  @override
  State<PayNowScreen> createState() => _PayNowScreenState();
}

class _PayNowScreenState extends State<PayNowScreen> {
  late MyUserInfo myUserInfo;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    myUserInfo = context.read<AuthBloc>().state.myUserInfo;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        // if (state is ChildrenParentAddState) {
        //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        //     Navigator.pushNamedAndRemoveUntil(
        //         context, PaymentSuccessScreen.routName, (route) => false);
        //   });
        // }

        if (state is ChildrenParentErrorState) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            if (dialogRunning) {
              Navigator.pushNamedAndRemoveUntil(
                  context, NavigationBarScreen.routeName, (route) => false);
              dialogRunning = false;
            }
          });
        }
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                S.of(context).pay_now,
              ),
            ),
            body: CheckoutView(
              childrenParent: widget.childrenParent,
              isEditing: widget.isEditing,
              myUserInfo: myUserInfo,
            ),
          ),
        );
      },
    );
  }
}
