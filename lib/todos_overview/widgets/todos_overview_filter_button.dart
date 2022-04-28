import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tod_app_bloc2/todos_overview/bloc/todos_overview_bloc.dart';
import 'package:tod_app_bloc2/todos_overview/models/models.dart';

class TodosOverviewFilterButton extends StatelessWidget {
  const TodosOverviewFilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final l10n = context.l10n;

    final activeFilter =
        context.select((TodosOverviewBloc bloc) => bloc.state.filter);

    return PopupMenuButton<TodosViewFilter>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      initialValue: activeFilter,
      tooltip: 'Filter',
      onSelected: (filter) {
        context
            .read<TodosOverviewBloc>()
            .add(TodosOverviewFilterChanged(filter));
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: TodosViewFilter.all,
            child: Text('Show All'),
          ),
          const PopupMenuItem(
            value: TodosViewFilter.activeOnly,
            child: Text('Show Active Only'),
          ),
          const PopupMenuItem(
            value: TodosViewFilter.completedOnly,
            child: Text('Show Completed Only'),
          ),
        ];
      },
      icon: const Icon(Icons.filter_list_rounded),
    );
  }
}
