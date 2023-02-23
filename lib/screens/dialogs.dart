//import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rehab_care/widgets/widgets_export.dart';

import '../config/config_export.dart';

bool dialogRunning = false;

void showLoadingDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (context) {
        dialogRunning = true;
        return WillPopScope(
          onWillPop: () async {
            // dialogRunning = true;
            return false;
          },
          child: Center(
            key: key,
            child: const CupertinoActivityIndicator(),
          ),
        );
      });
}

void killLoading(BuildContext context, bool flag, {String? error}) {
  if (dialogRunning) {
    Navigator.pop(context);
    dialogRunning = false;
    if (flag && error != null) {
      myCustomShowSnackBarText(context, error);
    }
  }
}

Widget confirmModal(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 200,
    alignment: Alignment.center,
    color: Theme.of(context).cardColor,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.of(context).confirm,
          textScaleFactor: 1.2,
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => Navigator.of(context).pop(false),
              child: Container(
                width: 80,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
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
            const SizedBox(
              width: 40,
            ),
            InkWell(
              onTap: () => Navigator.of(context).pop(true),
              child: Container(
                width: 80,
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).textTheme.caption?.color,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  S.of(context).ok,
                  textScaleFactor: 1,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Widget imageModal(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 250,
    alignment: Alignment.center,
    color: Theme.of(context).cardColor,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => Navigator.of(context).pop(0),
          child: Container(
            width: MediaQuery.of(context).size.width - 100,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: Theme.of(context).textTheme.caption?.color ??
                        const Color(0xFFFFFFFF),
                    width: 1)),
            alignment: Alignment.center,
            child: Text(
              S.of(context).remove,
              textScaleFactor: 1,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        // InkWell(
        //   onTap: () => Navigator.of(context).pop(1),
        //   child: Container(
        //     width: MediaQuery.of(context).size.width - 100,
        //     height: 40,
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(12),
        //         border: Border.all(
        //             color: Theme.of(context).textTheme.caption?.color ??
        //                 const Color(0xFFFFFFFF),
        //             width: 1)),
        //     alignment: Alignment.center,
        //     child: Text(
        //       S.of(context).remove,
        //       textScaleFactor: 1,
        //     ),
        //   ),
        // ),
        // const SizedBox(
        //   height: 20,
        // ),
        InkWell(
          onTap: () => Navigator.of(context).pop(2),
          child: Container(
            width: MediaQuery.of(context).size.width - 100,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).textTheme.caption?.color,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              S.of(context).change,
              textScaleFactor: 1,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    ),
  );
}

GlobalKey key = GlobalKey();

Widget noNetwork(BuildContext context, VoidCallback retry) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    color: Theme.of(context).scaffoldBackgroundColor,
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.wifi_off,
          size: 45,
          color: Theme.of(context).errorColor,
        ),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: retry,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Theme.of(context).errorColor,
                borderRadius: BorderRadius.circular(22)),
            child: Text(
              S.of(context).retry,
              textScaleFactor: 0.9,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    ),
  );
}

Widget noData(BuildContext context) {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        AppAssets.noData,
        width: 100,
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
        S.of(context).no_data,
        textScaleFactor: 1,
        style: const TextStyle(fontWeight: FontWeight.w400),
      )
    ],
  ));
}
