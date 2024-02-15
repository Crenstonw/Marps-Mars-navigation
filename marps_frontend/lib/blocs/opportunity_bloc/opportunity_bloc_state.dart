part of 'opportunity_bloc_bloc.dart';

@immutable
sealed class OpportunityBlocState {}

final class OpportunityInitial extends OpportunityBlocState {}

final class OpportunityBlocInitial extends OpportunityBlocState {}

final class OpportunityFetchSuccess extends OpportunityBlocState {
  final List<Photo> photoList;
  OpportunityFetchSuccess(this.photoList);
}

final class OpportunityFetchError extends OpportunityBlocState {
  final String errorMessage;
  OpportunityFetchError(this.errorMessage);
}
