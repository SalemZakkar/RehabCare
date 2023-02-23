import 'package:flutter/material.dart';
import 'package:rehab_care/screens/dialogs.dart';
import 'package:rehab_care/screens/home/bloc/treat_plans_bloc/treat_plans_bloc.dart';
import 'package:rehab_care/screens/home/home_export.dart';

class ViewTreatingPlan extends StatefulWidget {
  static const String routeName = "/viewPlan";
  final String id;
  final String name;

  const ViewTreatingPlan({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  State<ViewTreatingPlan> createState() => _ViewTreatingPlanState();
}

class _ViewTreatingPlanState extends State<ViewTreatingPlan> {
  bool able = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider<TreatPlansBloc>(
      create: (context) => TreatPlansBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
          centerTitle: true,
        ),
        body: BlocBuilder<TreatPlansBloc, TreatPlansState>(
          builder: (context, state) {
            if (state is TreatPlansInitial) {
              if (able) {
                context
                    .read<TreatPlansBloc>()
                    .add(GetTreatPlanInfo(id: widget.id));
                able = false;
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is TreatPlanInfoDone) {
              return Container(
                width: size.width,
                height: size.height,
                padding: const EdgeInsets.all(25),
                constraints: const BoxConstraints.expand(),
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          width: size.width,
                          child: Text(
                            state.treatmentPlanData.planText ?? "n/a",
                            textScaleFactor: 1.3,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            state.treatmentPlanData.subDate.toString(),
                            textScaleFactor: 1,
                          ),
                        ),
                      ],
                    )),
              );
            }
            if (state is TreatError) {
              return noNetwork(context, () {
                context
                    .read<TreatPlansBloc>()
                    .add(GetTreatPlanInfo(id: widget.id));
              });
            }
            return const Center();
          },
        ),
      ),
    );
  }
}
