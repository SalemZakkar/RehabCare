import 'package:flutter/material.dart';
import 'package:rehab_care/screens/dialogs.dart';
import 'package:rehab_care/screens/home/bloc/treat_plans_bloc/treat_plans_bloc.dart';
import 'package:rehab_care/screens/home/home_export.dart';

import '../../config/config_export.dart';
import 'widget/widget_export.dart';

class AllTreatingPlansScreen extends StatefulWidget {
  final String childId;
  final String majorId;
  static const String routeName = "/allTreatingPlans";

  const AllTreatingPlansScreen(
      {Key? key, required this.childId, required this.majorId})
      : super(key: key);

  @override
  State<AllTreatingPlansScreen> createState() => _AllTreatingPlansScreenState();
}

class _AllTreatingPlansScreenState extends State<AllTreatingPlansScreen> {
  @override
  initState() {
    context.read<TreatPlansBloc>().add(
        GetTreatPlanEvent(majorId: widget.majorId, childId: widget.childId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).treatment_plans),
        centerTitle: true,
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        alignment: Alignment.center,
        child: BlocBuilder<TreatPlansBloc, TreatPlansState>(
          builder: (context, state) {
            if (state is TreatPlansInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is TreatPlansDone) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 3, mainAxisSpacing: 3),
                itemBuilder: (context, index) {
                  return TreatingPlanHolder(
                    treatPlan: state.list[state.list.length - index - 1],
                  );
                },
                itemCount: state.list.length,
              );
            }
            if (state is TreatError) {
              return noNetwork(context, () {
                context.read<TreatPlansBloc>().add(GetTreatPlanEvent(
                    majorId: widget.majorId, childId: widget.childId));
              });
            }
            if (state is PlanIsEmptyState) {
              return noData(context);
            }
            return const Center();
          },
        ),
      ),
    );
  }
}
