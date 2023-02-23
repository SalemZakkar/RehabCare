import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../config/config_export.dart';
import '../../services/services_export.dart';
import '../../widgets/widgets_export.dart';
import '../authentication/authentication_export.dart';
import '../home/home_export.dart';
import '../screens_export.dart';
import 'navigation_bar_export.dart';

int index = 0;

class NavigationBarScreen extends StatefulWidget {
  static const String routeName = 'navigation_bar_screen';

  const NavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  static List mainScreen = [
    const HomeScreen(),
    const NotificationScreen(),
    const MedicalFileScreen(),
    const PersonalScreen(),
  ];

  Future requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> titleAppBar = [
      S.of(context).home,
      S.of(context).notification,
      S.of(context).med_file,
      S.of(context).profile
    ];
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSignOutState) {
          debugPrint(state.toString());
          Navigator.of(context).pushReplacementNamed(SplashScreen.routeName);
        }
        if (state is AuthErrorLogInState) {
          Navigator.of(context)
              .pushReplacementNamed(AuthenticationScreen.routeName);
        }
      },
      builder: (context, state) {
        debugPrint(state.toString());
        if (state is AuthSignInState ||
            state is AuthUpdateUserInfoState ||
            state is AuthChangePasswordState ||
            state is AuthChangePasswordErrorState ||
            state is AuthWaitingState ||
            state is AuthErrorState ||
            state is AuthChangeInfoErrorState) {
          return BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return BlocBuilder<NavigationBarBloc, NavigationBarState>(
                builder: (context, state) {
                  requestPermission();
                  fireBaseOnMessageListen(context);
                  fireBaseMessagingOnMessageOpenedApp(context);
                  initMessage(context);

                  ///if u change ur mind delete the builder and keep the scaffold;
                  // return OfflineBuilder(
                  //   connectivityBuilder: (context, connection, child) {
                  //     if (connection != ConnectivityResult.none) {
                  //
                  //     } else {
                  //       return Center(
                  //         child: noNetwork(context),
                  //       );
                  //     }
                  //   },
                  //   child: const Center(),
                  // );
                  return Scaffold(
                    appBar: myAppBar(titleAppBar[state.indexScreen]),
                    drawer: DrawerScreen(
                      index: index,
                    ),
                    // drawer: state.indexScreen == 0
                    //     ? DrawerScreen(
                    //         index: index,
                    //       )
                    //     : null,
                    body: mainScreen[state.indexScreen],
                    bottomNavigationBar: BottomAppBar(
                      color: Theme.of(context).cardColor,
                      // color: Colors.white,
                      child: SizedBox(
                        height: 50.0,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                                flex: 2,
                                child: _myCustomButtonNavBar(
                                    context: context,
                                    iconType: Icons.home,
                                    screenNumber: 0)),
                            Expanded(
                                flex: 2,
                                child: _myCustomButtonNavBar(
                                    context: context,
                                    iconType: Icons.notifications,
                                    screenNumber: 1)),
                            Expanded(
                                flex: 2,
                                child: _myCustomButtonNavBar(
                                    context: context,
                                    iconType: Icons.edit_note,
                                    screenNumber: 2)),
                            Expanded(
                                flex: 2,
                                child: _myCustomButtonNavBar(
                                    context: context,
                                    iconType: Icons.person,
                                    screenNumber: 3)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else {
          debugPrint(state.toString());
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _myCustomButtonNavBar({
    required BuildContext context,
    required iconType,
    required int screenNumber,
  }) {
    return GestureDetector(
      onTap: () {
        context
            .read<NavigationBarBloc>()
            .add(NavigationBarChangeEvent(screenNumber));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              width: double.maxFinite,
              color: Theme.of(context).cardColor,
              child: Icon(
                iconType,
                color: context.read<NavigationBarBloc>().state.indexScreen ==
                        screenNumber
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).textTheme.caption?.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
