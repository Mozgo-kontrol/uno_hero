part of 'scope_bloc.dart';

@immutable
sealed class ScopeState {}

final class ScopeInitialState extends ScopeState {
}
final class OnLoadingDataState extends ScopeState {
}
final class LoadedDataState extends ScopeState {
  final String tournamentName;
  final List<ScoreBoardItem> listOfScoresBoardItems;
  final Map<int, ScoreEntity> mapOfScoresPlayer;
  LoadedDataState({required this.listOfScoresBoardItems, required this.mapOfScoresPlayer, required  this.tournamentName});
}