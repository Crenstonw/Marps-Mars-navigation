part of 'opportunity_detail_bloc_bloc.dart';

@immutable
sealed class OpportunityDetailBlocState {}

final class OpportunityDetailInitial extends OpportunityDetailBlocState {}

final class OppotunityDetailBlocInitial extends OpportunityDetailBlocState {}

final class OpportunityDetailFetchSuccess extends OpportunityDetailBlocState {
  final List<Camera> cameraList;
  OpportunityDetailFetchSuccess(this.cameraList);
}

final class OpportunityDetailFetchError extends OpportunityDetailBlocState {
  final String errorMessage;
  OpportunityDetailFetchError(this.errorMessage);
}