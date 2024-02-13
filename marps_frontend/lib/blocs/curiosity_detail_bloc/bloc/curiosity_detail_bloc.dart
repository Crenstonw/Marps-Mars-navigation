import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:marps_frontend/models/curiosity/camera_detail_response/camera_detail_response.dart';
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
      final photoList = await cameraDetailRepository.fetchPhotos();
      emit(PhotoFetched(photoList));
      return;
    } on Exception catch (e) {
      emit(PhotoFetchError(e.toString()));
    }
  }
}
