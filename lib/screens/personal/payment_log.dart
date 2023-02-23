import 'package:flutter/material.dart';
import 'package:rehab_care/screens/authentication/authentication_export.dart';
import 'package:rehab_care/screens/dialogs.dart';
import 'package:rehab_care/screens/personal/personal_export.dart';

import '../../config/config_export.dart';
import 'widget/export_widget.dart';

class PaymentLog extends StatefulWidget {
  static const String routeName = "/paymentLog";

  const PaymentLog({Key? key}) : super(key: key);

  @override
  State<PaymentLog> createState() => _PaymentLogState();
}

class _PaymentLogState extends State<PaymentLog> {
  @override
  void initState() {
    String id = context.read<AuthBloc>().state.myUserInfo.userId ?? "";
    context.read<PersonalBloc>().add(PaymentLogGet(id: id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).last_payments),
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        constraints: const BoxConstraints.expand(),
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(15),
        child: BlocBuilder<PersonalBloc, PersonalState>(
          builder: (context, state) {
            if (state is PersonalInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PaymentLogData) {
              if (state.data.isEmpty) {
                return noData(context);
              }
              return ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  return PaymentLogCard(
                    paymentLogModel: state.data[index],
                  );
                },
              );
            } else {
              return noNetwork(context, () {
                String id =
                    context.read<AuthBloc>().state.myUserInfo.userId ?? "";
                context.read<PersonalBloc>().add(PaymentLogGet(id: id));
              });
            }
          },
        ),
      ),
    );
  }
}
