import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;

import '../bloc/bloc_export.dart';
import '../config/config_export.dart';
import '../services/services_export.dart';
import '../web_services/web_services_export.dart';
import '../widgets/widgets_export.dart';
import 'authentication/bloc/auth_bloc.dart';
import 'screens_export.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = 'splash_screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> startTime() async {
    Timer(const Duration(seconds: 3), (() async {
      if (context.read<AuthBloc>().state.myUserInfo.phone != null) {
        Navigator.of(context)
            .pushReplacementNamed(NavigationBarScreen.routeName);
      } else {
        Navigator.of(context)
            .pushReplacementNamed(AuthenticationScreen.routeName);
      }
    }));
  }

  startApp() async {
    WebConnection();
    tz.initializeTimeZones();
    await NotificationServices().initNotification();
  }

  @override
  initState() {
    super.initState();
    startTime();
    startApp();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitialState) {
          context.read<AuthBloc>().add(AuthGetPrefUserInfoEvent());
        }
        if (state is AuthGetPrefUserInfoState) {
          if (state.myUserInfo.phone != null) {
            context.read<AuthBloc>().add(AuthSignInEven(
                  phoneNumber: state.myUserInfo.phone!,
                  passwordEvent: state.myUserInfo.password!,
                  displayName: '-',
                  tokenFCM: '-',
                  isSignIn: true,
                  autoSignIn: true,
                ));
          }
        }
        return Scaffold(
          key: _scaffoldKey,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: 100.0),
                Expanded(
                  child: Image.asset(
                    AppAssets.transparentLogo,
                    height: 200.0,
                    width: 200.0,
                    fit: BoxFit.contain,
                  ),
                ),
                const EndSplashScreen(size: 140),
              ],
            ),
          ),
        );
      },
    );
  }
}
