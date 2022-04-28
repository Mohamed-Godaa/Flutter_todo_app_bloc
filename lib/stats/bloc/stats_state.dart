part of 'stats_bloc.dart';

enum StatsStatus { initial, loading, success, failure }

class StatsState extends Equatable {
  const StatsState({
    this.status = StatsStatus.initial,
    this.activeTodos = 0,
    this.completedTodos = 0,
  });

  final StatsStatus status;
  final int activeTodos;
  final int completedTodos;

  StatsState copyWith({
    StatsStatus? status,
    int? completedTodos,
    int? activeTodos,
  }) =>
      StatsState(
        status: status ?? this.status,
        completedTodos: completedTodos ?? this.completedTodos,
        activeTodos: activeTodos ?? this.activeTodos,
      );

  @override
  List<Object> get props => [completedTodos, activeTodos, status];
}
