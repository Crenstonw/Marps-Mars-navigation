import 'package:bloc/bloc.dart';
import 'package:marps_frontend/models/curiosity/mars_photos_curiosity_response/mars_photos_curiosity_response.dart';
import 'package:meta/meta.dart';
import 'package:marps_frontend/repositories/camera_detail_repository.dart';

part 'curiosity_detail_event.dart';
part 'curiosity_detail_state.dart';

class CuriosityDetailBloc
    extends Bloc<CuriosityDetailEvent, CuriosityDetailState> {
  final CameraDetailRepository cameraDetailRepository;
  CuriosityDetailBloc(this.cameraDetailRepository)
      : super(CuriosityDetailInitial()) {
    on<CuriosityDetailEvent>(_onCuriosityDetailFetch);
  }

  void _onCuriosityDetailFetch(
      CuriosityDetailEvent event, Emitter<CuriosityDetailState> emit) async {
    try {
      final photoList = await cameraDetailRepository.fetchDetails();
      emit(DetailFetched(photoList));
      return;
    } on Exception catch (e) {
      emit(DetailFetchError(e.toString()));
    }
  }
}
