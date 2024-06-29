part of 'manage_scores_bloc.dart';


sealed class ManageScoresState {}

final class InitialState extends ManageScoresState {
}
final class OnLoadingState extends ManageScoresState {
}

final class ShowScreenManageScoresState extends ManageScoresState{
  final List<PlayerEntity> listOfPlayers;
  ShowScreenManageScoresState({required this.listOfPlayers});

}
