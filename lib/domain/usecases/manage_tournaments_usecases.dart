import 'package:uno_notes/domain/entities/tournament_entity.dart';

import '../repositories/tournament_repository.dart';

class ManageTournamentsUsecases {

  final TournamentRepository tournamentRepository;
  ManageTournamentsUsecases({required this.tournamentRepository});

  Future<List<TournamentEntity>> getAllTournamentsUsecase() async {
    return tournamentRepository.getAllTournamentsFromApi();
  }
  Future<List<TournamentEntity>> getAllActiveTournaments() async {
    return tournamentRepository.getAllActiveTournaments();
  }
  Future<List<TournamentEntity>> getAllFinishedTournaments() async {
    return tournamentRepository.getAllFinishedTournaments();
  }
  Future<TournamentEntity> findTournamentById(int id) async {
    return tournamentRepository.findTournamentById(id);
  }
  Future<void> updateTournament(TournamentEntity tournamentEntity) async{
    tournamentRepository.updateTournament(tournamentEntity);
  }
  Future<void> finishTournament(int id) async{
    tournamentRepository.finishTournament(id);
  }

  Future<void> removeTournamentById(int id) async{
    tournamentRepository.removeTournamentById(id);
  }
}