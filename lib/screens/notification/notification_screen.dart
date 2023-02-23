import 'package:flutter/material.dart';
import 'package:rehab_care/screens/authentication/authentication_export.dart';
import 'package:rehab_care/screens/dialogs.dart';
import 'package:rehab_care/screens/notification/notification_export.dart';

import 'widget/widget_export.dart';

class NotificationScreen extends StatefulWidget {
  static const String routeName = 'notification_screen';

  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    context.read<NotificationBloc>().add(GetNotificationsEvent(
        myUserInfo: context.read<AuthBloc>().state.myUserInfo));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        debugPrint(state.toString());
        if (state is NotificationInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NotificationError) {
          return noNetwork(context, () {
            context.read<NotificationBloc>().add(GetNotificationsEvent(
                myUserInfo: context.read<AuthBloc>().state.myUserInfo));
          });
        } else if (state is NotificationSuccess) {
          if (state.data.isEmpty) {
            return noData(context);
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return NotificationCard(
                  notifications: state.data[index],
                );
              },
              itemCount: state.data.length,
            );
          }
        } else {
          return const Center();
        }
      },
    );
  }
}
