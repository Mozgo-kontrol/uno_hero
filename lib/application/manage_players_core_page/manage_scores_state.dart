part of 'manage_scores_bloc.dart';


sealed class ManageScoresState {}

final class InitialState extends ManageScoresState {
}
final class OnLoadingState extends ManageScoresState {
}

final class ShowScreenManageScoresState extends ManageScoresState{
  final Map<PlayerEntity, ScoreEntity> mapOfScores;
  ShowScreenManageScoresState({required this.mapOfScores});

}
