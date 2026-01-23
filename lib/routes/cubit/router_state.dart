part of 'router_cubit.dart';

@immutable
sealed class RouterState extends Equatable {
  const RouterState();

  @override
  List<Object?> get props => [];
}

final class RouterInitial extends RouterState {
  final String? lastKnownRoute;

  const RouterInitial({this.lastKnownRoute});

  @override
  List<Object?> get props => [lastKnownRoute];
}