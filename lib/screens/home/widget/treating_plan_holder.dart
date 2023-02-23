import 'package:flutter/material.dart';
import 'package:rehab_care/screens/home/model/treat_plan.dart';

import '../../../config/config_export.dart';
import '../../screens_export.dart';

class TreatingPlanHolder extends StatefulWidget {
  final TreatPlan treatPlan;

  const TreatingPlanHolder({Key? key, required this.treatPlan})
      : super(key: key);

  @override
  State<TreatingPlanHolder> createState() => _TreatingPlanHolderState();
}

class _TreatingPlanHolderState extends State<TreatingPlanHolder> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ViewTreatingPlan.routeName,
            arguments: ViewTreatingPlan(
                id: widget.treatPlan.planId ?? "",
                name: widget.treatPlan.planName ?? ""));
      },
      child: Container(
        width: size.width * 0.45,
        height: 220,
        alignment: Alignment.center,
        color: Theme.of(context).cardColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.treatment),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.treatPlan.planName ?? "n/a",
              textScaleFactor: 1,
            )
          ],
        ),
      ),
    );
  }
}
