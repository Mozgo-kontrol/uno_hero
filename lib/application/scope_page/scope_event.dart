part of 'scope_bloc.dart';

@immutable
sealed class ScopeEvent {}

class LoadScopesEvent extends ScopeEvent  {
 final ScopeScreenArguments arguments;
 LoadScopesEvent({required this.arguments});
}
class RefreshScopesEvent extends  ScopeEvent {}

class OpenManageScopesDialogEvent extends  ScopeEvent {}

class UpdatePlayerScoreEvent extends  ScopeEvent {
 final Map<int, int> mapOfPlayersScores;
 UpdatePlayerScoreEvent({required this.mapOfPlayersScores});
}

class UpdateOnePlayerScoreEvent{
 final int playerId;
 final int updatedScore;
 UpdateOnePlayerScoreEvent({required this.playerId,required this.updatedScore});
}
