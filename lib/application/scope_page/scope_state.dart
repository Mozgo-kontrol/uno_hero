part of 'scope_bloc.dart';

@immutable
sealed class ScopeState {}

final class ScopeInitialState extends ScopeState {
}
final class OnLoadingDataState extends ScopeState {
}
final class LoadedDataState extends ScopeState {
  final List<ScoreEntity> scores;
  LoadedDataState({required this.scores});
}