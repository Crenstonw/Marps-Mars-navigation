part of 'opportunity_detail_bloc_bloc.dart';

@immutable
sealed class OpportunityDetailBlocEvent {}

class OpportunityFetchList extends OpportunityDetailBlocEvent {
  OpportunityFetchList();
}
