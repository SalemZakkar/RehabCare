import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../config/config_export.dart';
import 'services_export.dart';

class NotificationFireBaseCloudMessaging {}

void setTopicToken() async {
  await FirebaseMessaging.instance.subscribeToTopic("alldevice").then((value) {
    printLog("done Subscribe To Topic allDevice");
  }).catchError((error) {
    printLog("Error Subscribe To Topic allDevice");
  });
}

// Future<void> sendNotification(String uid, String title, String body) async {
//   String token = await getToken(uid);
//   const String serverToken =
//       'AAAAT6C7xpw:APA91bEY-wXBDR-kFGEdrmcUNIKcu-QU2M4xJjBpePyaTqb3dFHswd7muSWpBh2amON2J-OAcGNMcblBoK6JrcV9ysQV1Ln4qr9tONnJwR0635piseVi1rGBeynWiaC397zySwn7e2xD';
//   final Uri s = Uri.parse("https://fcm.googleapis.com/fcm/send");
//   await http.post(
//     s,
//     headers: <String, String>{
//       'Content-Type': 'application/json',
//       'Authorization': 'key=$serverToken',
//     },
//     body: jsonEncode(
//       <String, dynamic>{
//         'notification': <String, dynamic>{
//           'body': body,
//           'title': title,
//         },
//         'priority': 'high',
//         'data': <String, dynamic>{
//           'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//           'id': '1',
//           'status': 'done'
//         },
//         'to': token,
//       },
//     ),
//   );
//   // await FirebaseMessaging.instance.subscribeToTopic("topic");
// }

/// if Open app is Run
fireBaseOnMessageListen(BuildContext context) {
  FirebaseMessaging.onMessage.listen((event) async {
    printLog('===== onMessage if Open app is Run =====');
    printLog(event.notification!.body.toString());

    NotificationServices().showNotification(
        1,
        event.notification!.title.toString(),
        event.notification!.body.toString(),
        3);

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     backgroundColor: Colors.red.withOpacity(0.0),
    //     content: Container(
    //       height: 100.0,
    //       color: Colors.red,
    //       child: Column(
    //         children: [
    //           Text(event.notification!.title.toString()),
    //           Text(event.notification!.body.toString()),
    //         ],
    //       ),
    //     ),
    //     duration: const Duration(milliseconds: 5000),
    //   ),
    // );
  });
}

/// if app in background
fireBaseMessagingOnMessageOpenedApp(BuildContext context) {
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    printLog('===== onMessage if app in background =====');

    // Navigator.of(context).pushNamed(UploadFileCloudStorage.routeName);
  });
}

/// if app is close
Future<void> initMessage(BuildContext context) async {
  RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    printLog('===== onMessage if app is close =====');

    // Navigator.of(context).pushNamed(StreamScreen.routeName);
  }
}

// Replace with server token from firebase console settings.
// final String serverToken = '<Server-Token>';
// final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
//
// Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
//   await firebaseMessaging.requestNotificationPermissions(
//     const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
//   );
//
//   await http.post(
//     'https://fcm.googleapis.com/fcm/send',
//     headers: <String, String>{
//       'Content-Type': 'application/json',
//       'Authorization': 'key=$serverToken',
//     },
//     body: jsonEncode(
//       <String, dynamic>{
//         'notification': <String, dynamic>{
//           'body': 'this is a body',
//           'title': 'this is a title'
//         },
//         'priority': 'high',
//         'data': <String, dynamic>{
//           'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//           'id': '1',
//           'status': 'done'
//         },
//         'to': await firebaseMessaging.getToken(),
//       },
//     ),
//   );
//
//   final Completer<Map<String, dynamic>> completer =
//   Completer<Map<String, dynamic>>();
//
//   firebaseMessaging.configure(
//     onMessage: (Map<String, dynamic> message) async {
//       completer.complete(message);
//     },
//   );
//
//   return completer.future;
// }
