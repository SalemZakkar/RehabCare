import 'package:flutter/material.dart';
import 'package:rehab_care/screens/contact_help/bloc/contact_help_bloc.dart';
import 'package:rehab_care/screens/dialogs.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/config_export.dart';
import '../authentication/authentication_export.dart';

class HelpCenter extends StatefulWidget {
  static const String routeName = "/helpCenter";

  const HelpCenter({Key? key}) : super(key: key);

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  late String locale;
  bool loaded = false;
  String whatsapp = "",
      facebook = "",
      twitter = "",
      instagram = "",
      youtube = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    locale = Localizations.localeOf(context).languageCode;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).help_center),
        centerTitle: true,
      ),
      body: BlocProvider<ContactHelpBloc>(
        create: (context) => ContactHelpBloc(),
        child: BlocBuilder<ContactHelpBloc, ContactHelpState>(
          builder: (context, state) {
            if (state is ContactHelpInitial) {
              context.read<ContactHelpBloc>().add(GetHelpCenterInfoEvent());
              loaded = false;
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                setState(() {});
              });
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ContactHelpError) {
              loaded = false;
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                setState(() {});
              });
              return noNetwork(context, () {
                context.read<ContactHelpBloc>().add(GetHelpCenterInfoEvent());
              });
            }
            if (state is ContactHelpSuccess) {
              whatsapp = state.aboutApp.whatsapp ?? "n/a";
              facebook = state.aboutApp.facebook ?? "n/a";
              twitter = state.aboutApp.twitter ?? "n/a";
              youtube = state.aboutApp.youtube ?? "n/a";
              instagram = state.aboutApp.instagram ?? "n/a";
              loaded = true;
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                setState(() {});
              });
              return Container(
                width: size.width,
                height: size.height,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        state.aboutApp.text ?? " ",
                        textScaleFactor: 1.3,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center();
            }
          },
        ),
      ),
      bottomNavigationBar: (loaded
          ? Container(
              width: size.width,
              height: 90,
              color: Theme.of(context).scaffoldBackgroundColor,
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      S.of(context).contact_us,
                      textScaleFactor: 1.2,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.caption?.color),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            await launchUrl(Uri.parse(whatsapp));
                          },
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            AppAssets.whatsapp,
                            width: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () async {
                            debugPrint(facebook);
                            await launchUrl(Uri.parse(facebook));
                          },
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            AppAssets.facebook,
                            width: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () async {
                            await launchUrl(Uri.parse(twitter));
                          },
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            AppAssets.twitter,
                            width: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () async {
                            await launchUrl(Uri.parse(instagram));
                          },
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            AppAssets.instagram,
                            width: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () async {
                            await launchUrl(Uri.parse(youtube));
                          },
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            AppAssets.youtube,
                            width: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox()),
    );
  }
}
