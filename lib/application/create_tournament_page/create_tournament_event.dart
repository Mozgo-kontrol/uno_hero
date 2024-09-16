part of 'create_tournamet_bloc.dart';

abstract class CreateTournamentEvent {}

class CreateTournamentInitEvent extends CreateTournamentEvent{}

class AddPlayerEvent extends CreateTournamentEvent {
  final String playerName;
  final int playerIconId;
  AddPlayerEvent(this.playerName, this.playerIconId);
}

class RemovePlayerEvent extends CreateTournamentEvent {
  final int playerId;
  RemovePlayerEvent(this.playerId);
}

class UpdateTitleEvent extends CreateTournamentEvent {
  final String title;
  UpdateTitleEvent(this.title);
}

class StartTournamentEvent extends CreateTournamentEvent {}
