import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'mars_photos_curiosity_bloc_event.dart';
part 'mars_photos_curiosity_bloc_state.dart';

class MarsPhotosCuriosityBlocBloc extends Bloc<MarsPhotosCuriosityBlocEvent, MarsPhotosCuriosityBlocState> {
  MarsPhotosCuriosityBlocBloc() : super(MarsPhotosCuriosityBlocInitial()) {
    on<MarsPhotosCuriosityBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
