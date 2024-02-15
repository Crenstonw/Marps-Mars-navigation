import 'package:bloc/bloc.dart';
import 'package:marps_frontend/blocs/opportunity_bloc/opportunity_bloc_bloc.dart';
import 'package:marps_frontend/repositories/opportunity/opportunity_repository.dart';
import 'package:meta/meta.dart';

part 'oppotunity_detail_bloc_event.dart';
part 'oppotunity_detail_bloc_state.dart';

class OppotunityDetailBlocBloc extends Bloc<OppotunityDetailBlocEvent, OppotunityDetailBlocState> {
  final OpportunityRepository opportunityRepository;

  OpportunityBloc(this.opportunityRepository)
      : super(OpportunityBlocInitial()) {
    on<OpportunityFetchList>(_onOpportunityFetchList);
  }

  void _onOpportunityFetchList(
      OpportunityFetchList event, Emitter<OpportunityBlocState> emit) async {
    try {
      final photoList =
          await opportunityRepository.fetchOpportunityPhotos(event.sol);
      emit(OpportunityFetchSuccess(photoList));
      return;
    } on Exception catch (e) {
      emit(OpportunityFetchError(e.toString()));
    }
  }
}
