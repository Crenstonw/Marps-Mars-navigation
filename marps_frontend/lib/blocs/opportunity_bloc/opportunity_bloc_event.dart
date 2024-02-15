part of 'opportunity_bloc_bloc.dart';

@immutable
sealed class OpportunityBlocEvent {}

class OpportunityFetchList extends OpportunityBlocEvent {
  final int sol;
  OpportunityFetchList(this.sol);
}
