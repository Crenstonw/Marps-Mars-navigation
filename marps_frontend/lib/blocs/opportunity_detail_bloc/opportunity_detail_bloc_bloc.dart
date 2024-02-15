import 'package:bloc/bloc.dart';
import 'package:marps_frontend/models/opportunity_photos/opportunity_photos.dart';
import 'package:marps_frontend/repositories/opportunity/opportunity_detail_repository.dart';
import 'package:meta/meta.dart';

part 'opportunity_detail_bloc_event.dart';
part 'opportunity_detail_bloc_state.dart';

class OpportunityDetailBlocBloc extends Bloc<OpportunityDetailBlocEvent, OpportunityDetailBlocState> {
  final OpportunityDetailRepository opportunityRepository;

  OpportunityDetailBlocBloc(this.opportunityRepository)
      : super(OppotunityDetailBlocInitial()) {
    on<OpportunityFetchList>(_onOpportunityDetailFetchList);
  }

  void _onOpportunityDetailFetchList(
      OpportunityFetchList event, Emitter<OpportunityDetailBlocState> emit) async {
    try {
      final cameraList =
          await opportunityRepository.fetchOpportunityCameras();
      emit(OpportunityDetailFetchSuccess(cameraList));
      return;
    } on Exception catch (e) {
      emit(OpportunityDetailFetchError(e.toString()));
    }
  }
}
