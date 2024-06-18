import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../presantation/create_tournament_page/scope_screen_arguments.dart';

part 'scope_event.dart';
part 'scope_state.dart';

class ScopeBloc extends Bloc<ScopeEvent, ScopeState> {
  ScopeBloc() : super(ScopeInitial()) {


    on<LoadScopesEvent>(_initScopes);
    on<RefreshScopesEvent>(_refreshScopes);

  }
}

void _initScopes(LoadScopesEvent event, Emitter<ScopeState> emit) {

}
void _refreshScopes(RefreshScopesEvent event, Emitter<ScopeState> emit) {

}