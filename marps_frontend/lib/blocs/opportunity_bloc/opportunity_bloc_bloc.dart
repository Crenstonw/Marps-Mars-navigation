import 'package:bloc/bloc.dart';
import 'package:marps_frontend/models/opportunity_photos/opportunity_photos.dart';
import 'package:marps_frontend/repositories/opportunity/opportunity_repository.dart';
import 'package:meta/meta.dart';

part 'opportunity_bloc_event.dart';
part 'opportunity_bloc_state.dart';

class OpportunityBloc extends Bloc<OpportunityBlocEvent, OpportunityBlocState> {
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
