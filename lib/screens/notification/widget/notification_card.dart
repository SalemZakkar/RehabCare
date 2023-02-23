import 'package:flutter/material.dart';
import 'package:rehab_care/screens/notification/models/notifications.dart';

class NotificationCard extends StatefulWidget {
  final Notifications notifications;

  const NotificationCard({Key? key, required this.notifications})
      : super(key: key);

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Theme.of(context).cardColor,
                scrollable: true,
                title: Text(
                  widget.notifications.title ?? "n/a",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText2?.color),
                ),
                content: Container(
                  padding: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 300,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Text(
                      widget.notifications.text  ?? "n/a",
                      textScaleFactor: 1.2,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2?.color),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            });
      },
      child: Column(
        children: [
          Container(
            width: size.width,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.notifications.title ?? "n/a",
                    textScaleFactor: 1,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText2?.color),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      widget.notifications.dateTime.toString().split(" ").first,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1?.color),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: size.width,
            height: 0.5,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
