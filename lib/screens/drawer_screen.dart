import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

import '../bloc/bloc_export.dart';
import '../bloc/model/model_export.dart';
import '../config/config_export.dart';
import 'authentication/authentication_export.dart';
import 'navigation_bar/navigation_bar_export.dart';
import 'screens_export.dart';

class DrawerScreen extends StatefulWidget {
  final int index;

  const DrawerScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  Map<bool, Color> buttonColor = {true: blueColor, false: Colors.grey};
  late String locale;

  @override
  void initState() {
    super.initState();
    context
        .read<ServicesBloc>()
        .add(DrawerGetInfoEvent(context.read<AuthBloc>().state.myUserInfo));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    locale = Localizations.localeOf(context).toString();
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      width: size.width * 0.6,
      height: size.height,
      //padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: size.width * 0.6,
                  height: size.height * 0.03,
                ),
                Container(
                  width: size.width * 0.6,
                  height: 200,
                  alignment: Alignment.center,
                  child: Image.asset(AppAssets.transparentLogo,
                      width: size.width * 0.25),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: locale == "en" ? 10 : 0,
                      top: 5,
                      bottom: 10,
                      right: locale == "ar" ? 10 : 0),
                  child: Align(
                    alignment: locale == 'en'
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Text(
                      S.of(context).welcome,
                      textScaleFactor: 1.2,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2?.color,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: locale == "en" ? 20 : 0,
                      bottom: 20,
                      right: locale == "ar" ? 20 : 0),
                  child: Align(
                    alignment: locale == 'en'
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Text(
                      context.read<AuthBloc>().state.myUserInfo.name.toString(),
                      textScaleFactor: 1.1,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2?.color,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {});
                    context
                        .read<NavigationBarBloc>()
                        .add(NavigationBarChangeEvent(0));
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: size.width * 0.6,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.home_outlined,
                          color: buttonColor[0 == widget.index],
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Text(
                          S.of(context).home,
                          textScaleFactor: 1,
                          style:
                              TextStyle(color: buttonColor[0 == widget.index]),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context
                        .read<NavigationBarBloc>()
                        .add(NavigationBarChangeEvent(3));
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: size.width * 0.6,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.person_outline,
                          color: buttonColor[1 == widget.index],
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Text(
                          S.of(context).profile,
                          textScaleFactor: 1,
                          style:
                              TextStyle(color: buttonColor[1 == widget.index]),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, PaymentLog.routeName);
                  },
                  child: Container(
                    width: size.width * 0.6,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.payment_outlined,
                          color: buttonColor[2 == widget.index],
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Text(
                          S.of(context).last_payments,
                          textScaleFactor: 1,
                          style:
                              TextStyle(color: buttonColor[2 == widget.index]),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, SettingScreen.routeName);
                  },
                  child: Container(
                    width: size.width * 0.6,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.settings,
                          color: buttonColor[3 == widget.index],
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Text(
                          S.of(context).settings,
                          textScaleFactor: 1,
                          style:
                              TextStyle(color: buttonColor[3 == widget.index]),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, ContactUs.routeName);
                  },
                  child: Container(
                    width: size.width * 0.6,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.question_answer_outlined,
                          color: buttonColor[4 == widget.index],
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Text(
                          S.of(context).contact_us,
                          textScaleFactor: 1,
                          style:
                              TextStyle(color: buttonColor[4 == widget.index]),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, HelpCenter.routeName);
                  },
                  child: Container(
                    width: size.width * 0.6,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.help_outline,
                          color: buttonColor[5 == widget.index],
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Text(
                          S.of(context).help_center,
                          textScaleFactor: 1,
                          style:
                              TextStyle(color: buttonColor[5 == widget.index]),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    DrawerInfo drawerInfo =
                        context.read<ServicesBloc>().state.drawerInfo;

                    await FlutterShare.share(
                      title: 'Rehab Care',
                      // text: 'Example share text',
                      linkUrl:
                          "${drawerInfo.iosUrl.toString()}\n\n${drawerInfo.playStoreUrl}",
                      // chooserTitle: 'Example Chooser Title',
                    );
                  },
                  child: Container(
                    width: size.width * 0.6,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.share_outlined,
                          color: buttonColor[6 == widget.index],
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Text(
                          S.of(context).share,
                          textScaleFactor: 1,
                          style:
                              TextStyle(color: buttonColor[6 == widget.index]),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.read<AuthBloc>().add(AuthSignOutEven());
                    context
                        .read<NavigationBarBloc>()
                        .add(NavigationBarChangeEvent(3));
                    Navigator.pushNamedAndRemoveUntil(context,
                        AuthenticationScreen.routeName, (route) => false);
                  },
                  child: Container(
                    width: size.width * 0.6,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.door_front_door_outlined,
                          color: buttonColor[7 == widget.index],
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Text(
                          S.of(context).exit,
                          textScaleFactor: 1,
                          style:
                              TextStyle(color: buttonColor[7 == widget.index]),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
