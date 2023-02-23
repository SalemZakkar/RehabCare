import 'package:flutter/material.dart';
import 'package:rehab_care/config/validator.dart';
import 'package:rehab_care/screens/dialogs.dart';
import 'package:rehab_care/screens/screens_export.dart';

import '../../bloc/bloc_export.dart';
import '../../config/config_export.dart';

class ContactUs extends StatefulWidget {
  static const String routeName = "/contactUs";

  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController num = TextEditingController();
  TextEditingController message = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).contact_us),
        centerTitle: true,
      ),
      body: BlocBuilder<ServicesBloc, ServicesState>(
        builder: (context, state) {
          if (state is FeedBackDone) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              killLoading(context, false);
              Navigator.pushNamedAndRemoveUntil(
                  context, NavigationBarScreen.routeName, (route) => false);
            });
          }
          if (state is FeedBackError) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              killLoading(context, true, error: S.of(context).network_error);
            });
          }
          return Container(
            width: size.width,
            height: size.height,
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        AppAssets.contactUsImage,
                        width: 150,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    TextFormField(
                      controller: name,
                      decoration: InputDecoration(hintText: S.of(context).name),
                      validator: (data) {
                        if (!Validator.checkName(data ?? " ")) {
                          return "${S.of(context).name} ${S.of(context).notValid}";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: email,
                      decoration:
                          InputDecoration(hintText: S.of(context).email),
                      validator: (data) {
                        if (!Validator.checkEmail(data ?? " ")) {
                          return "${S.of(context).email} ${S.of(context).notValid}";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: num,
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration(hintText: S.of(context).phone_number),
                      validator: (data) {
                        if (!Validator.checkNumber(data ?? " ")) {
                          return "${S.of(context).phone_number} ${S.of(context).notValid}";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: message,
                      decoration:
                          InputDecoration(hintText: S.of(context).message),
                      validator: (text) {
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {});
                        if (key.currentState!.validate()) {
                          showLoadingDialog(context);
                          context.read<ServicesBloc>().add(SendFeedBackEvent(
                                name: name.text,
                                email: email.text,
                                phone: num.text,
                                message: message.text,
                              ));
                        }
                        setState(() {});
                      },
                      child: Container(
                        width: size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            color: blueColor,
                            borderRadius: BorderRadius.circular(5)),
                        alignment: Alignment.center,
                        child: Text(
                          S.of(context).send,
                          style: const TextStyle(color: Colors.white),
                          textScaleFactor: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: size.width * 0.3,
                          height: 1,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          S.of(context).or,
                          textScaleFactor: 1,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: size.width * 0.3,
                          height: 1,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: size.width,
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.phone_rounded,
                            color: blueColor,
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          Text(
                            S.of(context).call_helping_center,
                            textScaleFactor: 1.2,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
