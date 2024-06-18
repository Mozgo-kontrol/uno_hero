import 'package:uno_notes/domain/entities/tournament_entity.dart';

import '../repositories/TournamentRepository.dart';

class ManageTournamentsUsecases {

  final TournamentRepository tournamentRepository;


  ManageTournamentsUsecases({required this.tournamentRepository});

  Future<List<TournamentEntity>> getAllTournamentsUsecase() async {
    return tournamentRepository.getAllTournamentsFromApi();
  }
  Future<TournamentEntity> findTournamentById(int id) async {
    return tournamentRepository.findTournamentById(id);
  }
}