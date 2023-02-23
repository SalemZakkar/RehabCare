import 'package:flutter/material.dart';
import 'package:rehab_care/config/validator.dart';
import 'package:rehab_care/screens/dialogs.dart';
import 'package:rehab_care/screens/screens_export.dart';

import '../../config/config_export.dart';
import '../authentication/authentication_export.dart';

class NewPassword extends StatefulWidget {
  static const String routeName = "/new_password";

  const NewPassword({Key? key}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController password = TextEditingController();
  TextEditingController password2 = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  bool obscure = true;
  bool pop = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).change_password),
      ),
      body: Form(
        key: key,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(left: 10, right: 10),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 10),
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Image.asset(AppAssets.changePassword),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                TextFormField(
                  obscureText: obscure,
                  validator: (value) {
                    if (value != password2.text) {
                      return S.of(context).not_equal;
                    }
                    if (!Validator.checkPassword(value ?? "")) {
                      return "${S.of(context).password} ${S.of(context).not_valid2}";
                    }
                    return null;
                  },
                  controller: password,
                  decoration: InputDecoration(hintText: S.of(context).new_pass),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  obscureText: obscure,
                  controller: password2,
                  validator: (value) {
                    if (value != password.text) {
                      return S.of(context).not_equal;
                    }
                    if (!Validator.checkPassword(value ?? "")) {
                      return "${S.of(context).password} ${S.of(context).not_valid2}";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: S.of(context).retype_new_password),
                ),
                const SizedBox(
                  height: 30,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthErrorState) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        killLoading(context, true,
                            error: S.of(context).network_error);
                      });
                    }
                    if (state is AuthChangePasswordState) {
                      dialogRunning = false;
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        if (pop) {
                          pop = false;
                          Navigator.pushNamedAndRemoveUntil(context,
                              NavigationBarScreen.routeName, (route) => false);
                        }
                      });
                    }
                    debugPrint(state.toString());
                    return GestureDetector(
                      onTap: () {
                        ///change password button
                        if (key.currentState!.validate()) {
                          showLoadingDialog(context);
                          pop = true;
                          context
                              .read<AuthBloc>()
                              .add(AuthChangePasswordEvent(password.text));
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Theme.of(context).textTheme.caption?.color,
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          S.of(context).ok,
                          textScaleFactor: 1,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
