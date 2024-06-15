import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_tournament_event.dart';
part 'create_tournament_state.dart';

class CreateTournamentBloc extends Bloc<CreateTournametEvent, CreateTournamentState> {
  CreateTournamentBloc() : super(CreateTournamentInitial()) {
    on<CreateTournametEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
