part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<ChildrenParent> listChildrenParent;
  final List<Major> listMajor;

  const HomeState(this.listChildrenParent, this.listMajor);

  @override
  List<Object> get props => [listChildrenParent, listMajor];
}

class HomeInitial extends HomeState {
  const HomeInitial(super.listChildrenParent, super.listMajor);
}

class ChildrenParentGetState extends HomeState {
  final List<BannerModel> bannerModel;

  const ChildrenParentGetState(super.listChildrenParent, super.listMajor,
      {required this.bannerModel});
}

class ChildrenParentErrorState extends HomeState {
  final String errorBody;

  const ChildrenParentErrorState(
      super.listChildrenParent, this.errorBody, super.listMajor);
}

class ErrorAddState extends HomeState {
  const ErrorAddState(super.listChildrenParent, super.listMajor);
}

class MajorGetState extends HomeState {
  const MajorGetState(super.listChildrenParent, super.listMajor);
}

class ChildrenParentAddState extends HomeState {
  final ChildrenParent newChildrenParent;

  @override
  List<Object> get props => [newChildrenParent];

  const ChildrenParentAddState(
      super.listChildrenParent, super.listMajor, this.newChildrenParent);
}

class ChildrenParentUpdateState extends HomeState {
  const ChildrenParentUpdateState(super.listChildrenParent, super.listMajor);
}

class ChildrenParentDeleteState extends HomeState {
  const ChildrenParentDeleteState(super.listChildrenParent, super.listMajor);
}

class DeleteAttachmentState extends HomeState {
  final String name;
  const DeleteAttachmentState(super.listChildrenParent, super.listMajor,
      {required this.name});
}

class AttachmentInitial extends HomeState {
  const AttachmentInitial(super.listChildrenParent, super.listMajor);
}

/// may Edit
class GetAllVideoState extends HomeState {
  final List<VideoModel> listVideoModel;
  final bool isLoading;

  @override
  List<Object> get props => [listVideoModel, isLoading];

  const GetAllVideoState(super.listChildrenParent, super.listMajor,
      this.listVideoModel, this.isLoading);
}

class HomeError extends HomeState {
  const HomeError(super.listChildrenParent, super.listMajor);
}

class GetTherapeuticSessionsState extends HomeState {
  final List<AllAssessmentVideo> listAllAssessmentVideo;
  final bool isLoading;

  @override
  List<Object> get props => [listAllAssessmentVideo, isLoading];

  const GetTherapeuticSessionsState(super.listChildrenParent, super.listMajor,
      this.listAllAssessmentVideo, this.isLoading);
}

class UploadAssessmentVideoState extends HomeState {
  final bool isLoading;
  final bool isDone;
  final int sending;
  final int total;
  final String presenting;

  @override
  List<Object> get props => [isLoading, isDone, sending, total, presenting];

  const UploadAssessmentVideoState(super.listChildrenParent, super.listMajor,
      {required this.sending,
      required this.total,
      required this.presenting,
      required this.isLoading,
      required this.isDone});
}

class UploadErrorState extends HomeState {
  final String errorBody;

  const UploadErrorState(super.listChildrenParent, super.listMajor,
      {required this.errorBody});
}

class UploadDone extends HomeState {
  const UploadDone(super.listChildrenParent, super.listMajor);
}
