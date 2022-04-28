import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tod_app_bloc2/home/home_cubit.dart';
import 'package:tod_app_bloc2/stats/view/stats_page.dart';
import 'package:tod_app_bloc2/todos_overview/view/todos_overview_page.dart';

import '../edit_todo/view/view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);
    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: const [TodosOverviewPage(), StatsPage()],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        key: const Key('homeView_addTodo_floatingActionButton'),
        onPressed: () {
          Navigator.of(context).push(EditTodoPage.route());
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _HomeTabButton(
              icon: const Icon(Icons.list_rounded),
              value: HomeTab.todos,
              groupValue: selectedTab,
            ),
            _HomeTabButton(
              icon: const Icon(Icons.show_chart_rounded),
              value: HomeTab.stats,
              groupValue: selectedTab,
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.icon,
  }) : super(key: key);

  final HomeTab value;
  final HomeTab groupValue;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      iconSize: 32,
      color:
          groupValue != value ? null : Theme.of(context).colorScheme.secondary,
      onPressed: () => context.read<HomeCubit>().setTab(value),
    );
  }
}
