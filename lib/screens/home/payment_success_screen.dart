import 'dart:async';

import 'package:flutter/material.dart';

import '../../config/config_export.dart';
import '../screens_export.dart';

class PaymentSuccessScreen extends StatefulWidget {
  static const String routName = "paymentSuccess";

  const PaymentSuccessScreen({Key? key}) : super(key: key);

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Timer(const Duration(seconds: 1), () {
        Navigator.pushNamedAndRemoveUntil(
            context, NavigationBarScreen.routeName, (route) => false);
      });
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).pay_now),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              AppAssets.successPerson,
              height: size.height * 0.4,
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            Image.asset(AppAssets.success),
            SizedBox(
              height: size.height * 0.05,
            ),
            Text(
              S.of(context).success,
              textScaleFactor: 1.2,
              style: const TextStyle(color: blueColor),
            )
          ],
        ),
      ),
    );
  }
}
