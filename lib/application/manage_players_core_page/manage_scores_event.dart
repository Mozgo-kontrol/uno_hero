part of 'manage_scores_bloc.dart';

sealed class ManageScoresEvent {}
class InitManageScoresEvent extends  ManageScoresEvent  {
  final int tournamentId;
  InitManageScoresEvent({required this.tournamentId});
}

class layerScoreEvent extends  ManageScoresEvent{
  final int playerId;
  final int score;
  layerScoreEvent({required this.score, required this.playerId});
}