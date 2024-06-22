part of 'manage_scores_bloc.dart';

sealed class ManageScoresEvent {}
class InitManageScoresEvent extends  ManageScoresEvent  {
  final int tournamentId;
  InitManageScoresEvent({required this.tournamentId});
}

class UpdatePlayerScoreEvent extends  ManageScoresEvent{
  final int playerId;
  final int score;
  UpdatePlayerScoreEvent({required this.score, required this.playerId});
}