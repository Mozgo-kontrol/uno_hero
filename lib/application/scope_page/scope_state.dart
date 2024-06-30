part of 'scope_bloc.dart';

@immutable
sealed class ScopeState {}

final class ScopeInitialState extends ScopeState {
}
final class OnLoadingDataState extends ScopeState {
}
final class LoadedDataState extends ScopeState {
  final String tournamentTitle;
  final List<ScoreBoardItem> listOfScoresBoardItems;
  final bool isFinished;
  LoadedDataState({required this.listOfScoresBoardItems, required  this.tournamentTitle, required this.isFinished});
}

