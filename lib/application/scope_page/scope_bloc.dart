import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'scope_event.dart';
part 'scope_state.dart';

class ScopeBloc extends Bloc<ScopeEvent, ScopeState> {
  ScopeBloc() : super(ScopeInitial()) {
    on<ScopeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
