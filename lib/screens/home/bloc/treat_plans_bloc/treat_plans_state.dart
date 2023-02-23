part of 'treat_plans_bloc.dart';

@immutable
abstract class TreatPlansState {}

class TreatPlansInitial extends TreatPlansState {}

class TreatPlansDone extends TreatPlansState {
  final List<TreatPlan> list;

  TreatPlansDone({required this.list});
}

class TreatError extends TreatPlansState {}

class TreatPlanInfoDone extends TreatPlansState {
  final TreatmentPlanData treatmentPlanData;

  TreatPlanInfoDone({required this.treatmentPlanData});
}

class PlanIsEmptyState extends TreatPlansState {}

class AddReportDone extends TreatPlansState {
  final String res;

  AddReportDone({required this.res});
}
