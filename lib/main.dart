import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rehab_care/screens/home/bloc/treat_plans_bloc/treat_plans_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock/wakelock.dart';

import 'bloc/bloc_export.dart';
import 'config/config_export.dart';
import 'screens/authentication/bloc/auth_bloc.dart';
import 'screens/home/home_export.dart';
import 'screens/medical_file/medical_file_export.dart';
import 'screens/navigation_bar/navigation_bar_export.dart';
import 'screens/notification/notification_export.dart';
import 'screens/personal/personal_export.dart';
import 'screens/screens_export.dart';

/// run in background for notification
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  // print("Handling a background message: ${message.messageId}");
  // print(
  //     "Handling a background message: ${message.notification!.title.toString()}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int theme = ThemeManage.getTheme();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        /// Start Other Bloc Provider
        /// disable
        BlocProvider<ServicesBloc>(
            create: (BuildContext context) => ServicesBloc()),
        BlocProvider<PersonalBloc>(
          create: (BuildContext context) => PersonalBloc(),
        ),

        /// Start  Bloc Provider for Screen
        /// Part 1 => 1 to 5
        BlocProvider<AuthBloc>(create: (BuildContext context) => AuthBloc()),
        BlocProvider<HomeBloc>(create: (BuildContext context) => HomeBloc()),
        BlocProvider<TreatPlansBloc>(
          create: (BuildContext context) => TreatPlansBloc(),
        ),

        ///disable
        BlocProvider<MedicalFileBloc>(
            create: (BuildContext context) => MedicalFileBloc()),
        BlocProvider<NavigationBarBloc>(
            create: (BuildContext context) => NavigationBarBloc()),
        BlocProvider<NotificationBloc>(
            create: (BuildContext context) => NotificationBloc()),

        /// Part 2 => 6 to 10
        BlocProvider<PersonalBloc>(
            create: (BuildContext context) => PersonalBloc()),

        /// End Bloc Provider for Screen
      ],
      child: BlocBuilder<ServicesBloc, ServicesState>(
        builder: (context, state) {
          if (state is ServicesInitialState) {
            context.read<ServicesBloc>().add(GetServicesPrefEvent());
          }
          return MaterialApp(
            locale: Locale.fromSubtags(languageCode: LanguageManager.getLang()),
            supportedLocales: S.delegate.supportedLocales,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            debugShowCheckedModeBanner: false,
            title: 'Rehab Care',
            theme: ThemeManage.appThemes[ThemeManage.getTheme()],
            home: const SplashScreen(),
            onGenerateRoute: AppRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}

Future<void> init() async {
  pref = await SharedPreferences.getInstance();
  await Wakelock.enable();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
