import 'package:flutter/material.dart';
import 'package:rehab_care/widgets/widgets_export.dart';

import '../../../bloc/bloc_export.dart';
import '../../../config/config_export.dart';
import '../../../services/services_export.dart';
import '../../dialogs.dart';
import '../../screens_export.dart';
import '../bloc/auth_bloc.dart';
import '../models/models_export.dart';
import 'widget_export.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({Key? key}) : super(key: key);

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  String phoneNumber = "";
  String password = "";
  bool resetPassword = false;
  String countryKey = "+971";

  @override
  void initState() {
    setTopicToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        printLog(state);
        if (state is AuthSignInState) {
          killLoading(context, false);
          Navigator.of(context).pushNamedAndRemoveUntil(
              NavigationBarScreen.routeName, (route) => false);
        }
        if (state is AuthErrorLogInState) {
          killLoading(context, false);
          myCustomShowSnackBarText(context, state.errorBody);
        }
      },
      builder: (context, state) {
        printLog(state);
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 36.0),
          child: Column(
            children: [
              ///Entry Phone Number
              Form(
                key: formState,
                child: Column(
                  children: [
                    /// Phone Number
                    TextFormField(
                      keyboardType: TextInputType.number,
                      maxLength: 9,
                      decoration: InputDecoration(
                        suffix: Text(countryKey),
                        // prefixIcon: const Icon(Icons.phone),
                        hintText: S.of(context).phone_number,
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: blueColor),
                        ),
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: blueColor),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: blueColor),
                        ),
                      ),
                      onSaved: (value) {
                        phoneNumber = value.toString();
                      },
                      validator: (value) {
                        var val = value!.trim();
                        if (val.length < 9) {
                          return "${S.of(context).phone_number} ${S.of(context).wrong}";
                        }
                        return null;
                      },
                    ),

                    /// Password
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        // prefixIcon: const Icon(Icons.password),
                        hintText: S.of(context).password,
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: blueColor),
                        ),
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: blueColor),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: blueColor),
                        ),
                      ),
                      onSaved: (value) {
                        password = value.toString();
                      },
                      validator: (value) {
                        if (resetPassword == true) {
                          return null;
                        }

                        if (value!.length < 5) {
                          return "${S.of(context).password_is_less} ${5}";
                        }

                        return null;
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12.0),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        resetPassword = true;
                        FocusScope.of(context).unfocus();

                        setState(() {});
                        FormState? formData = formState.currentState;
                        if (formData!.validate()) {
                          printLog("Valid");
                          formData.save();
                          MyUserInfo myUserInfo =
                              MyUserInfo(phone: phoneNumber);

                          context
                              .read<AuthBloc>()
                              .add(AuthForGetPasswordEvent(myUserInfo));

                          printLog('Reset Password');
                        } else {
                          printLog("Not Valid");
                        }
                        resetPassword = false;
                        setState(() {});
                      },
                      child: Text(S.of(context).forgetP)),
                ],
              ),
              const SizedBox(height: 10.0),
              GestureDetector(
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  printLog('SingIn');
                  FormState? formData = formState.currentState;
                  if (formData!.validate()) {
                    printLog("Valid");
                    formData.save();
                    showLoadingDialog(context);
                    context.read<AuthBloc>().add(AuthSignInEven(
                          phoneNumber: phoneNumber,
                          passwordEvent: password,
                          displayName: "displayName",
                          tokenFCM: await getDeviceToken(false),
                          isSignIn: true,
                          autoSignIn: false,
                        ));
                  } else {
                    printLog("Not Valid");
                  }
                },
                child: Container(
                  height: 32.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).textTheme.caption?.color,
                    borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                  ),
                  child: Text(S.of(context).signIn,
                      style: const TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
