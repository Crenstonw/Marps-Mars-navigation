part of 'curiosity_bloc.dart';

@immutable
sealed class CuriosityState {
  final List<Photo> photos;

  const CuriosityState({
    this.photos = const <Photo>[],
  });
}

final class CuriosityInitial extends CuriosityState {}

final class PhotoFetched extends CuriosityState {
  final List<Photo> photoList;
  const PhotoFetched(this.photoList);
}

final class PhotoFetchError extends CuriosityState {
  final String messageError;
  const PhotoFetchError(this.messageError);
}
