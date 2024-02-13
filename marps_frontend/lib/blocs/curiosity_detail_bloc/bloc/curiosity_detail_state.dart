part of 'curiosity_detail_bloc.dart';

@immutable
sealed class CuriosityDetailState {
  final List<Photo> photos;

  const CuriosityDetailState({
    this.photos = const <Photo>[],
  });
}

final class CuriosityDetailInitial extends CuriosityDetailState {}

final class DetailFetched extends CuriosityDetailState {
  final List<Photo> photoList;
  const DetailFetched(this.photoList);
}

final class DetailFetchError extends CuriosityDetailState {
  final String messageError;
  const DetailFetchError(this.messageError);
}
