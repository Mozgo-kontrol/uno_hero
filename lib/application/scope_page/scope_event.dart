part of 'scope_bloc.dart';

@immutable
sealed class ScopeEvent {}
class LoadScopesEvent extends ScopeEvent  {
 final ScopeScreenArguments arguments;
 LoadScopesEvent({required this.arguments});
}
class RefreshScopesEvent extends  ScopeEvent {}
