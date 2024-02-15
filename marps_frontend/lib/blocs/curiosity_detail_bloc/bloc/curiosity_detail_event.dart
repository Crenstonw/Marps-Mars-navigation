part of 'curiosity_detail_bloc.dart';

@immutable
sealed class CuriosityDetailEvent {
  String get name;
}

final class CuriosityDetailFetchEvent extends CuriosityDetailEvent {
  final String name;
  CuriosityDetailFetchEvent(this.name);
}
