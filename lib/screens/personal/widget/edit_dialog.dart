import 'package:flutter/material.dart';
import 'package:rehab_care/config/validator.dart';
import 'package:rehab_care/screens/dialogs.dart';
import 'package:rehab_care/screens/screens_export.dart';

import '../../../config/config_export.dart';
import '../../authentication/authentication_export.dart';
import '../../authentication/models/models_export.dart';

class EditDialog extends StatefulWidget {
  final String name, email;

  const EditDialog({Key? key, required this.name, required this.email})
      : super(key: key);

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  late TextEditingController name;
  late TextEditingController email;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void initState() {
    name = TextEditingController(text: widget.name);
    email = TextEditingController(text: widget.email);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
          "${S.of(context).edit} ${S.of(context).profile}",
          style: TextStyle(color: Theme.of(context).textTheme.bodyText2?.color),
        ),
        content: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 200,
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                validator: (value) {
                  if (!Validator.checkName(value ?? " ")) {
                    return "${S.of(context).name} ${S.of(context).notValid}";
                  }
                  return null;
                },
                controller: name,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: Theme.of(context).primaryColor,
                  ),
                  labelText: S.of(context).name,
                  labelStyle: TextStyle(color: Theme.of(context).dividerColor),
                  border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).dividerColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).dividerColor),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).dividerColor),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (!Validator.checkEmail(value ?? " ")) {
                    return "${S.of(context).email} ${S.of(context).notValid}";
                  }
                  return null;
                },
                controller: email,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Theme.of(context).primaryColor,
                  ),
                  labelText: S.of(context).email,
                  labelStyle: TextStyle(color: Theme.of(context).dividerColor),
                  border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).dividerColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).dividerColor),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).dividerColor),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 80,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).textTheme.caption?.color ??
                          const Color(0xFFFFFFFF),
                      width: 1)),
              alignment: Alignment.center,
              child: Text(
                S.of(context).cancel,
                textScaleFactor: 1,
              ),
            ),
          ),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthUpdateUserInfoState) {
                dialogRunning = false;
                Navigator.pushNamedAndRemoveUntil(
                    context, NavigationBarScreen.routeName, (route) => false);
              }
              if (state is AuthErrorState) {
                killLoading(context, true, error: S.of(context).network_error);
              }
            },
            builder: (context, state) {
              return InkWell(
                onTap: () {
                  if (key.currentState!.validate()) {
                    MyUserInfo newMyUserInfo = state.myUserInfo;
                    newMyUserInfo = newMyUserInfo.copyWith(
                        name: name.text.toString(),
                        email: email.text.toString(),
                        userId: state.myUserInfo.userId);
                    showLoadingDialog(context);
                    debugPrint(state.myUserInfo.userId);
                    context
                        .read<AuthBloc>()
                        .add(AuthUpdateUserInfoEvent(newMyUserInfo));
                  }
                },
                child: Container(
                  width: 80,
                  height: 40,
                  color: Theme.of(context).textTheme.caption?.color,
                  alignment: Alignment.center,
                  child: Text(
                    S.of(context).save,
                    textScaleFactor: 1,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
