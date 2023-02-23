import 'package:flutter/material.dart';
import 'package:rehab_care/screens/personal/model/payment_log_model.dart';

import '../../../config/config_export.dart';

class PaymentLogCard extends StatefulWidget {
  final PaymentLogModel paymentLogModel;

  const PaymentLogCard({Key? key, required this.paymentLogModel})
      : super(key: key);

  @override
  State<PaymentLogCard> createState() => _PaymentLogCardState();
}

class _PaymentLogCardState extends State<PaymentLogCard>
    with SingleTickerProviderStateMixin {
  bool expanded = false;
  Map<String, String> cardPhoto = {
    "visa": AppAssets.visa,
    "master": AppAssets.master,
    "mada": AppAssets.mada
  };
  late String locale;
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    locale = Localizations.localeOf(context).toString();
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              (expanded
                  ? animationController.reverse()
                  : animationController.forward());
              expanded = !expanded;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: size.width,
            height: expanded ? 270 : 70,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                                top: 10,
                                right: (locale == "en" ? 10 : 0),
                                bottom: 10,
                                left: (locale == "ar" ? 10 : 0)),
                            child: Image.asset(
                              AppAssets.cardLead,
                              width: 30,
                            )),
                        Text(
                          "${S.of(context).sub_no} ${widget.paymentLogModel.paymentId ?? ""}",
                          textScaleFactor: 1,
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: AnimatedIcon(
                            icon: AnimatedIcons.menu_close,
                            progress: animationController,
                          ),
                        )
                      ],
                    ),
                    // Text(
                    //   "2019/11/11",
                    //   textScaleFactor: 0.8,
                    //   style: TextStyle(color: Colors.grey),
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).pay_method,
                            textScaleFactor: 1,
                          ),
                          Image.asset(
                            cardPhoto[widget.paymentLogModel.paymentMethod
                                    .toString()
                                    .toLowerCase()] ??
                                "",
                            width: 80,
                            height: 50,
                            fit: BoxFit.contain,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).ben_name,
                            textScaleFactor: 1,
                          ),
                          Text(
                            widget.paymentLogModel.childName.toString(),
                            textScaleFactor: 0.8,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).status,
                            textScaleFactor: 1,
                          ),
                          Text(
                            widget.paymentLogModel.status.toString(),
                            textScaleFactor: 0.8,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).total,
                            textScaleFactor: 1,
                          ),
                          Text(
                            "${widget.paymentLogModel.amount.toString()} ${S.of(context).aed}",
                            textScaleFactor: 0.8,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ),
        Container(
          width: size.width,
          height: 0.5,
          color: Colors.grey,
        )
      ],
    );
  }
}
