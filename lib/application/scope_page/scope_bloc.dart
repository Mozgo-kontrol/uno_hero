import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uno_notes/domain/entities/tournament_entity.dart';

import '../../domain/entities/score_entity.dart';
import '../../domain/usecases/manage_tournaments_usecases.dart';
import '../../presantation/create_tournament_page/scope_screen_arguments.dart';

part 'scope_event.dart';
part 'scope_state.dart';

class ScopeBloc extends Bloc<ScopeEvent, ScopeState> {
  final ManageTournamentsUsecases usecases;
  ScopeBloc({required this.usecases}) : super(ScopeInitialState()) {
    on<LoadScopesEvent>(_initScopes);

  }

Future<void> _initScopes(LoadScopesEvent event, Emitter<ScopeState> emit) async {
  emit(OnLoadingDataState());
  int tournamentId = event.arguments.tournamentId;
  TournamentEntity tournament = await usecases.findTournamentById(tournamentId);
  emit(LoadedDataState(scores: initScoresForPlayers(tournament)));
}
List<ScoreEntity> initScoresForPlayers(TournamentEntity tournament){
  int position=1;

  List<ScoreEntity> list = [];
  for (var element in tournament.players) {
    list.add(ScoreEntity(playerId: element.id, score: 0, playerName: element.name, currentPosition: position++));
  }
  print("initScoresForPlayers $list");
  return  list;
}
}

