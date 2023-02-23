import 'package:flutter/material.dart';

import '../../bloc/bloc_export.dart';
import '../../config/config_export.dart';

class SettingScreen extends StatefulWidget {
  static const String routeName = "/settings";

  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int theme = ThemeManage.getTheme();
  String lang = LanguageManager.getLang();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
      ),
      body: BlocBuilder<ServicesBloc, ServicesState>(
        builder: (c, state) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(left: 10, right: 10),
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    AppAssets.settings,
                    width: 200,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    leading: const Icon(Icons.language_outlined),
                    title: Text(
                      S.of(context).language,
                      textScaleFactor: 0.9,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        groupValue: true,
                        value: LanguageManager.getLang() == "en",
                        onChanged: (b) {
                          c
                              .read<ServicesBloc>()
                              .add(const ChangeLanguageEvent(language: "en"));
                          setState(() {
                            lang = LanguageManager.getLang();
                          });
                        },
                      ),
                      Text(
                        S.of(context).english,
                        textScaleFactor: 1,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.15,
                      ),
                      Radio(
                        groupValue: true,
                        value: LanguageManager.getLang() == "ar",
                        onChanged: (b) {
                          c
                              .read<ServicesBloc>()
                              .add(const ChangeLanguageEvent(language: "ar"));
                          setState(() {
                            lang = LanguageManager.getLang();
                          });
                        },
                      ),
                      Text(
                        S.of(context).arabic,
                        textScaleFactor: 1,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    leading: const Icon(Icons.mode),
                    title: Text(
                      S.of(context).theme,
                      textScaleFactor: 0.9,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        groupValue: true,
                        value: ThemeManage.getTheme() == 0,
                        onChanged: (change) {
                          c
                              .read<ServicesBloc>()
                              .add(const ChangeModeThemeEvent(theme: 0));
                          setState(() {});
                        },
                      ),
                      Text(
                        S.of(context).light,
                        textScaleFactor: 1,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.15,
                      ),
                      Radio(
                        groupValue: true,
                        value: ThemeManage.getTheme() == 1,
                        onChanged: (b) {
                          c
                              .read<ServicesBloc>()
                              .add(const ChangeModeThemeEvent(theme: 1));
                          setState(() {});
                        },
                      ),
                      Text(
                        S.of(context).dark,
                        textScaleFactor: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
