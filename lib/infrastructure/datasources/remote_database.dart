
import 'package:hive/hive.dart';
import 'package:uno_notes/domain/entities/tournament_entity.dart';


abstract class LocalDataSource{
  ///request a random advice from free api
  ///throws a server-exception if response
  Future <List<TournamentEntity>>  getAllTournamentsFromApi();
  Future<TournamentEntity> addTournamentToDB(TournamentEntity tournamentEntity);
  Future<TournamentEntity> findTournamentById(int id);
  Future <int> getNextTournamentId();
  Future<void> updateTournament(TournamentEntity tournamentEntity);
  Future<void> finishTournament(int id);
}

class LocalDataSourceImpl implements LocalDataSource {

  final Box<TournamentEntity> _box;
  LocalDataSourceImpl(this._box);

  @override
  Future<List<TournamentEntity>> getAllTournamentsFromApi() {
    List<TournamentEntity> result=[];

    for (var element in _box.values) { result.add(element);}
     print("getAllTournaments $result");
      return Future.value(result);
  }

  @override
  Future<TournamentEntity> addTournamentToDB(TournamentEntity tournamentEntity) async {
    await _box.put(tournamentEntity.id, tournamentEntity);
    await _box.flush();
    print("added new tournament to db $tournamentEntity");
    print("in db last ${_box.values.last}");
    return  Future.value(_box.values.last);
  }
  @override
  Future <int> getNextTournamentId() {
    if(_box.values.isEmpty){
      return Future.value(1);
    }
    return Future.value(_box.values.last.id+1);
  }

  @override
  Future<TournamentEntity> findTournamentById(int id) {
    TournamentEntity? tournament = _box.get(id);
    if (tournament == null) {
      print('No tournament found for key $id');
    }
    return Future.value(tournament);
  }

  @override
  Future<void> updateTournament(TournamentEntity tournamentNew) async {
    if(_box.isOpen) {
      await _box.put(tournamentNew.id, tournamentNew);
      await _box.flush();
      print("updated tournament data in db ${tournamentNew.id}");
    }

  }

  @override
  Future<void> finishTournament(int id) async {
    TournamentEntity? tournament = _box.get(id);
    if (tournament != null) {
      tournament.isFinished = true;   //finish tournament
      tournament.winner = tournament.players.first; //find winner
      print("Tournament finished ${tournament.isFinished} and winner ${ tournament.winner.name}");
      await _box.put(id, tournament);
      await _box.flush();
    }
  }
}
