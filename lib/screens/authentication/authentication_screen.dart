import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../bloc/bloc_export.dart';
import '../../config/config_export.dart';
import '../../widgets/widgets_export.dart';
import 'widget/widget_export.dart';

enum AuthenticationTypeEnum {
  logIn,
  logUp,
  resetPassword,
}

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);
  static const routeName = 'authentication_screen';

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  AuthenticationTypeEnum userAuthenticationType = AuthenticationTypeEnum.logIn;
  late String displayName, password, email;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late String locale;
  List<String> listImage = [
    AppAssets.authenticationFirstCarousel,
    AppAssets.authenticationSecondCarousel,
  ];

  @override
  Widget build(BuildContext context) {
    //double hSize = MediaQuery.of(context).size.height;
    locale = Localizations.localeOf(context).toString();
    Map<String, String> lang = {
      "en": S.of(context).arabic,
      "ar": S.of(context).english
    };
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: Text(S.of(context).signIn),
      ),
      body: BlocBuilder<ServicesBloc, ServicesState>(builder: (context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              CarouselSlider.builder(
                itemCount: listImage.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Image.asset(listImage[itemIndex]),
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  aspectRatio: 2.0,
                  initialPage: 2,
                ),
              ),
              userAuthenticationType == AuthenticationTypeEnum.logIn
                  ? const SignInWidget()
                  : const SignUpWidget(),
              const SizedBox(height: 12.0),
              userAuthenticationType == AuthenticationTypeEnum.logIn
                  ? Row(
                      children: [
                        Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 36.0),
                            child: Text(S.of(context).dont_have_account,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.color))),
                        const Expanded(child: SizedBox()),
                        GestureDetector(
                          onTap: () {
                            userAuthenticationType =
                                AuthenticationTypeEnum.logUp;
                            setState(() {});
                          },
                          child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 36.0),
                              child: Text(
                                S.of(context).reg,
                                style: const TextStyle(color: yellowColor),
                              )),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            userAuthenticationType =
                                AuthenticationTypeEnum.logIn;
                            setState(() {});
                          },
                          child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 36.0),
                              child: Text(
                                S.of(context).already_have_account,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              )),
                        ),
                      ],
                    ),
              const SizedBox(height: 12.0),
              InkWell(
                onTap: () {
                  context.read<ServicesBloc>().add(ChangeLanguageEvent(
                      language: (locale == "en") ? "ar" : "en"));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 36 * 2,
                  height: 32,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: Theme.of(context).textTheme.caption?.color ??
                              Colors.blue)),
                  alignment: Alignment.center,
                  child: Text(
                    lang[locale] ?? "",
                    textScaleFactor: 0.9,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText2?.color),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: const EndSplashScreen(size: 120),
    );
  }
}
