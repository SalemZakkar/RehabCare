part of 'home_bloc.dart';

abstract class HomeEvent {}

class ChildrenParentGetEvent extends HomeEvent {
  final MyUserLogin myUserLogin;

  ChildrenParentGetEvent(this.myUserLogin);
}

class ChildrenParentUpdateEvent extends HomeEvent {
  final ChildrenParent oldChildrenParent;
  final ChildrenParent newChildrenParent;
  final int state;
  final File? photo;

  ChildrenParentUpdateEvent(
      {required this.oldChildrenParent,
      required this.newChildrenParent,
      required this.state,
      required this.photo});
}

class ChildrenParentAddEvent extends HomeEvent {
  final ChildrenParent childrenParent;
  final MyUserInfo myUserInfo;
  final File? photo;
  final String? notes;

  ChildrenParentAddEvent(this.childrenParent, this.myUserInfo,
      {this.photo, this.notes});
}

class ChildrenParentErrorEvent extends HomeEvent {
  final String errorBody;

  ChildrenParentErrorEvent(this.errorBody);
}

class ChildrenParentDeleteEvent extends HomeEvent {
  final ChildrenParent childrenParent;
  final MyUserInfo myUserInfo;

  ChildrenParentDeleteEvent(this.childrenParent, this.myUserInfo);
}

class MajorGetEvent extends HomeEvent {}

class DeleteAttachmentEvent extends HomeEvent {
  String name;

  DeleteAttachmentEvent({required this.name});
}

class StopHomeEvent extends HomeEvent {}

class GetAllVideoEvent extends HomeEvent {
  final String childId;
  final String majorId;

  GetAllVideoEvent(this.childId, this.majorId);
}

class GetTherapeuticSessionsEvent extends HomeEvent {
  final String childId;
  final String majorId;

  GetTherapeuticSessionsEvent(this.childId, this.majorId);
}

///TODO UploadVideoPart 3
class UploadAssessmentVideoEvent extends HomeEvent {
  final File videoFile;
  final String assessmentId;

  UploadAssessmentVideoEvent(this.videoFile, this.assessmentId);
}

class StopUploadingEvent extends HomeEvent {}
