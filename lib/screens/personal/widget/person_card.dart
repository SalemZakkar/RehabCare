import 'package:flutter/material.dart';

import '../../../config/config_export.dart';
import '../../authentication/authentication_export.dart';
import '../../authentication/models/models_export.dart';
import '../../screens_export.dart';
import 'export_widget.dart';

class PersonCardWidget extends StatefulWidget {
  const PersonCardWidget({Key? key}) : super(key: key);

  @override
  State<PersonCardWidget> createState() => _PersonCardWidgetState();
}

class _PersonCardWidgetState extends State<PersonCardWidget> {
  late MyUserInfo myUserInfo;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    myUserInfo = context.read<AuthBloc>().state.myUserInfo;
    return Container(
      width: size.width,
      height: 370,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 0, color: Colors.transparent),
        color: Theme.of(context).cardColor,
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                S.of(context).personal_info,
                textScaleFactor: 1,
              ),
              const Spacer(),
              InkWell(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => EditDialog(
                        name: myUserInfo.name ?? "",
                        email: myUserInfo.email ?? ""),
                  );
                },
                child: Text(
                  S.of(context).edit,
                  textScaleFactor: 1,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(
              Icons.person_outline,
              color: Theme.of(context).textTheme.caption?.color,
            ),
            title: Text(
              S.of(context).name,
              style: TextStyle(
                color: Theme.of(context).textTheme.caption?.color,
              ),
            ),
            subtitle: Text(myUserInfo.name ?? " ",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2?.color,
                )),
          ),
          ListTile(
            leading: Icon(
              Icons.email,
              color: Theme.of(context).textTheme.caption?.color,
            ),
            title: Text(
              S.of(context).email,
              style: TextStyle(
                color: Theme.of(context).textTheme.caption?.color,
              ),
            ),
            subtitle: Text(myUserInfo.email ?? " ",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2?.color,
                )),
          ),
          ListTile(
            leading: Icon(
              Icons.phone_in_talk_outlined,
              color: Theme.of(context).textTheme.caption?.color,
            ),
            title: Text(
              S.of(context).phone_number,
              style: TextStyle(
                color: Theme.of(context).textTheme.caption?.color,
              ),
            ),
            subtitle: Text(myUserInfo.phone ?? " ",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2?.color,
                )),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, NewPassword.routeName);
            },
            leading: Icon(
              Icons.vpn_key_outlined,
              color: Theme.of(context).textTheme.caption?.color,
            ),
            title: Text(
              S.of(context).password,
              style: TextStyle(
                color: Theme.of(context).textTheme.caption?.color,
              ),
            ),
            subtitle: Text(S.of(context).change_password,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2?.color,
                )),
          ),
        ],
      ),
    );
  }
}
