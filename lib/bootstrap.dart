import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:tod_app_bloc2/app/app.dart';
import 'package:todos_api/todos_api.dart';
import 'package:todos_repository/todos_repository.dart';

void bootstrap({required TodosApi todosApi}) {
  FlutterError.onError = (details) {
    log(
      details.exceptionAsString(),
      stackTrace: details.stack,
    );
  };

  final todosRepository = TodosRepository(todosApi: todosApi);

  runZonedGuarded(() async {
    await BlocOverrides.runZoned(
      () async => runApp(App(todosRepository: todosRepository)),
    );
  }, (error, stack) => log(error.toString(), stackTrace: stack));
}
