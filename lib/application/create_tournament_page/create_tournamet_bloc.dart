import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_tournamet_event.dart';
part 'create_tournamet_state.dart';

class CreateTournametBloc extends Bloc<CreateTournametEvent, CreateTournametState> {
  CreateTournametBloc() : super(CreateTournametInitial()) {
    on<CreateTournametEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
