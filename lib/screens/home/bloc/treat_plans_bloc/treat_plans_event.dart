part of 'treat_plans_bloc.dart';

@immutable
abstract class TreatPlansEvent {}

class GetTreatPlanEvent extends TreatPlansEvent {
  final String childId;
  final String majorId;

  GetTreatPlanEvent({required this.majorId, required this.childId});
}

class GetTreatPlanInfo extends TreatPlansEvent {
  final String id;

  GetTreatPlanInfo({required this.id});
}

class AddReport extends TreatPlansEvent {
  final String childId;
  final File file;

  AddReport({required this.childId, required this.file});
}
