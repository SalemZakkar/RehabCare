import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rehab_care/config/validator.dart';

import '../../../bloc/bloc_export.dart';
import '../../../config/config_export.dart';
import '../../../widgets/widgets_export.dart';
import '../../dialogs.dart';
import '../../screens_export.dart';
import '../bloc/auth_bloc.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  String userName = '';
  String phoneNumber = '';
  String email = '';
  String city = '';
  String password = '';

  String otpPin = " ";
  String verID = " ";

  String countryKey = "+971";

  /// Part 1  SignUp by phone number send sms Firebase
  Future<void> verifyPhone(BuildContext context, String number) async {
    printLog('Start send massage');
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      timeout: const Duration(seconds: 120),
      verificationCompleted: (PhoneAuthCredential credential) {
        myCustomShowSnackBarText(context, "Auth Completed");
      },
      verificationFailed: (FirebaseAuthException e) {
        killLoading(context, false);
        myCustomShowSnackBarText(context, "Auth Failed!");
        printLog(e.toString());
      },
      codeSent: (String verificationId, int? resendToken) async {
        myCustomShowSnackBarText(context, "OTP Sent!");
        verID = verificationId;
        setState(() {});
        await showDialog(
          context: context,
          useSafeArea: false,
          builder: (_) => ListView(
            padding: const EdgeInsets.symmetric(vertical: 70.0),
            children: [
              AlertDialog(
                // backgroundColor: yellowColor,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                insetPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                // title: Text((state.errorTitle.toString())),
                content: stateOTP(context),
                // backgroundColor: Colors.red,
                elevation: 24,
              ),
            ],
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        killLoading(context, false);
        myCustomShowSnackBarText(context, "Timeout!");
      },
    );
  }

  /// Part 2  SignUp by phone number send sms Firebase
  Widget stateOTP(BuildContext context) {
    return Container(
      height: 500.0,
      // width: double.maxFinite,
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Image.asset('assets/images/pass.jpg'),
          const SizedBox(
            height: 10,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(color: blueColor),
              children: [
                TextSpan(
                  text: S.current.confirm_code,
                ),
                TextSpan(
                  text: "\n$countryKey$phoneNumber",
                ),
                TextSpan(
                  text: '\n${S.of(context).enterCC}',
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          PinCodeTextField(
            appContext: context,
            length: 6,
            onChanged: (value) {
              setState(() {
                otpPin = value;
              });
            },
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () async {
              await verifyOTP();
            },
            child: Container(
                alignment: Alignment.center,
                height: 40.0,
                width: 100.0,
                decoration: BoxDecoration(
                  color: blueColor,
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: Text(
                  S.current.ok,
                  style: const TextStyle(color: yellowColor),
                )),
          ),
          const SizedBox(height: 10.0),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () {
                      killLoading(context, false);
                      Navigator.pop(context);
                    },
                    child: Text(
                      S.current.reCC,
                      style: const TextStyle(color: yellowColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(color: blueColor),
              children: [
                TextSpan(
                  text: "${S.current.pCC}\n",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Part 3  SignUp by phone number send sms Firebase
  Future<void> verifyOTP() async {
    await FirebaseAuth.instance
        .signInWithCredential(
      PhoneAuthProvider.credential(
        verificationId: verID,
        smsCode: otpPin,
      ),
    )
        .then((value) async {
      context.read<AuthBloc>().add(AuthSignInEven(
            phoneNumber: phoneNumber,
            userEmailEvent: email,
            passwordEvent: password,
            displayName: userName,
            tokenFCM: await getDeviceToken(false),
            isSignIn: false,
            autoSignIn: false,
          ));
    }).whenComplete(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthErrorLogInState) {
          killLoading(context, false);
          myCustomShowSnackBarText(context, state.errorBody);
        }
        if (state is AuthSignInState) {
          killLoading(context, false);
          Navigator.of(context)
              .pushReplacementNamed(NavigationBarScreen.routeName);
        }
      },
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 36.0),
          child: Column(
            children: [
              Form(
                key: formState,
                child: Column(
                  children: [
                    ///Entry UserName
                    TextFormField(
                      decoration: InputDecoration(
                        // prefixIcon: const Icon(Icons.person),
                        hintText: S.of(context).name,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Theme.of(context).textTheme.caption?.color ??
                                      const Color(0xFFFFFFFF)),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Theme.of(context).textTheme.caption?.color ??
                                      const Color(0xFFFFFFFF)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Theme.of(context).textTheme.caption?.color ??
                                      const Color(0xFFFFFFFF)),
                        ),
                      ),
                      onSaved: (value) {
                        userName = value!.trim();
                      },
                      validator: (value) {
                        if (value!.length > 40) {
                          return "${S.of(context).name} ${S.of(context).more} 40 ${S.of(context).char}";
                        }
                        if (value.length < 2) {
                          return "${S.of(context).name} ${S.of(context).less} 2 ${S.of(context).char}";
                        }
                        return null;
                      },
                    ),

                    /// Phone Number
                    TextFormField(
                      keyboardType: TextInputType.number,
                      maxLength: 9,
                      // textInputAction: ,
                      decoration: InputDecoration(
                        // prefixIcon: const Icon(Icons.person),
                        hintText: S.of(context).phone_number,
                        suffix: Text(countryKey.toString()),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Theme.of(context).textTheme.caption?.color ??
                                      const Color(0xFFFFFFFF)),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Theme.of(context).textTheme.caption?.color ??
                                      const Color(0xFFFFFFFF)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Theme.of(context).textTheme.caption?.color ??
                                      const Color(0xFFFFFFFF)),
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

                    ///Entry email
                    TextFormField(
                      decoration: InputDecoration(
                        // prefixIcon: const Icon(Icons.person),
                        hintText: S.of(context).email,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Theme.of(context).textTheme.caption?.color ??
                                      const Color(0xFFFFFFFF)),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Theme.of(context).textTheme.caption?.color ??
                                      const Color(0xFFFFFFFF)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Theme.of(context).textTheme.caption?.color ??
                                      const Color(0xFFFFFFFF)),
                        ),
                      ),
                      onSaved: (value) {},
                      validator: (value) {
                        if (!Validator.checkEmail(value ?? " ")) {
                          return "${S.of(context).email} ${S.of(context).notValid}";
                        }
                        return null;
                      },
                    ),

                    ///Entry City
                    TextFormField(
                      decoration: InputDecoration(
                        // prefixIcon: const Icon(Icons.person),
                        hintText: S.of(context).city,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Theme.of(context).textTheme.caption?.color ??
                                      const Color(0xFFFFFFFF)),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Theme.of(context).textTheme.caption?.color ??
                                      const Color(0xFFFFFFFF)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Theme.of(context).textTheme.caption?.color ??
                                      const Color(0xFFFFFFFF)),
                        ),
                      ),
                      onSaved: (value) {
                        city = value!.trim();
                      },
                      validator: (value) {
                        if (value!.length < 2) {
                          return "${S.of(context).city} ${S.of(context).wrong}";
                        }
                        return null;
                      },
                    ),

                    ///Entry password
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        // prefixIcon: const Icon(Icons.person),
                        hintText: S.of(context).password,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Theme.of(context).textTheme.caption?.color ??
                                      const Color(0xFFFFFFFF)),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Theme.of(context).textTheme.caption?.color ??
                                      const Color(0xFFFFFFFF)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Theme.of(context).textTheme.caption?.color ??
                                      const Color(0xFFFFFFFF)),
                        ),
                      ),
                      onSaved: (value) {
                        password = value!.trim();
                      },
                      validator: (value) {
                        if (value!.length > 25) {
                          return "${S.of(context).password} ${S.of(context).more} ${25} ${S.of(context).char}";
                        }
                        if (value.length < 5) {
                          return "${S.of(context).password} ${S.of(context).less} ${5} ${S.of(context).char}";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  FormState? formData = formState.currentState;
                  if (formData!.validate()) {
                    printLog("Valid");
                    formData.save();
                    setState(() {});
                    showLoadingDialog(context);
                    String fullNumber = countryKey + phoneNumber;
                    print("-------------------------");
                    printLog(fullNumber);
                    await verifyPhone(context, fullNumber);
                  } else {
                    printLog("Not Valid");
                  }
                  printLog('SingUp');
                },
                child: Container(
                    height: 32.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).textTheme.caption?.color,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(6.0)),
                    ),
                    child: Text(
                      S.of(context).reg,
                      style: const TextStyle(color: Colors.white),
                    )),
              ),
            ],
          ),
        );
      },
    );
  }
}

//TODO Sign Up

Future<String> getDeviceToken(bool autoSignIn) async {
  if (autoSignIn == true) {
    return "autoSignIn";
  } else {
    String token = await FirebaseMessaging.instance.getToken() ?? "?";
    return token;
  }
}
