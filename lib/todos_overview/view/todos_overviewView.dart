import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tod_app_bloc2/edit_todo/view/view.dart';
import 'package:tod_app_bloc2/todos_overview/bloc/todos_overview_bloc.dart';

import '../widgets/widgets.dart';

class TodosOverviewView extends StatelessWidget {
  const TodosOverviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        actions: const [
          TodosOverviewFilterButton(),
          TodosOverviewOptionsButton(),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TodosOverviewBloc, TodosOverviewState>(
            listener: (context, state) {
              if (state.status == TodosOverviewStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(content: Text('Error loading the todos')),
                  );
              }
            },
            listenWhen: (previous, current) =>
                previous.status != current.status,
            child: Container(),
          ),
          BlocListener<TodosOverviewBloc, TodosOverviewState>(
            listenWhen: (previous, current) =>
                previous.lastDeletedTodo != current.lastDeletedTodo &&
                current.lastDeletedTodo != null,
            listener: (context, state) {
              if (state.status == TodosOverviewStatus.failure) {
                final deletedTodo = state.lastDeletedTodo!;
                final messenger = ScaffoldMessenger.of(context);
                messenger
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text('Deleted ${deletedTodo.title} !'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          messenger.hideCurrentSnackBar();
                          context
                              .read<TodosOverviewBloc>()
                              .add(const TodosOverviewUndoDeletionRequested());
                        },
                      ),
                    ),
                  );
              }
            },
          ),
        ],
        child: BlocBuilder<TodosOverviewBloc, TodosOverviewState>(
          builder: (context, state) {
            if (state.todos.isEmpty) {
              if (state.status == TodosOverviewStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Center(
                  child: Text('No Todos yet, add some!'),
                );
              }
            }

            return CupertinoScrollbar(
              child: ListView(children: [
                for (final todo in state.filteredTodos)
                  TodoListTile(
                    todo: todo,
                    onToggleCompleted: (isCompleted) {
                      context.read<TodosOverviewBloc>().add(
                            TodosOverviewTodoCompletionToggled(
                              todo: todo,
                              isCompleted: isCompleted,
                            ),
                          );
                    },
                    onDismissed: (_) {
                      context
                          .read<TodosOverviewBloc>()
                          .add(TodosOverviewTodoDeleted(todo));
                    },
                    onTap: () {
                      Navigator.of(context).push(
                        EditTodoPage.route(initialTodo: todo),
                      );
                    },
                  ),
              ]),
            );
          },
        ),
      ),
    );
  }
}
