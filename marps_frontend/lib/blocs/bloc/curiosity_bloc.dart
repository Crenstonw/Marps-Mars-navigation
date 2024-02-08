import 'package:bloc/bloc.dart';
import 'package:marps_frontend/models/curiosity/mars_photos_curiosity_response/mars_photos_curiosity_response.dart';
import 'package:marps_frontend/repositories/curiosity_repository.dart';
import 'package:meta/meta.dart';

part 'curiosity_event.dart';
part 'curiosity_state.dart';

class CuriosityBloc extends Bloc<CuriosityEvent, CuriosityState> {
  final CuriosityRepository curiosityRepository;
  CuriosityBloc(this.curiosityRepository) : super(CuriosityInitial()) {
    on<CuriosityEvent>(_onCuriosityFetch);
  }

  void _onCuriosityFetch(
      CuriosityEvent event, Emitter<CuriosityState> emit) async {
    try {
      final photoList = await curiosityRepository.fetchPhotos();
      emit(PhotoFetched(photoList));
      return;
    } on Exception catch (e) {
      emit(PhotoFetchError(e.toString()));
    }
  }
}
