// ignore_for_file: public_member_api_docs, duplicate_ignore

import 'package:todos_api/todos_api.dart';

// ignore: duplicate_ignore
/// {@template todos_api}
/// The interface and models for an API providing access to todos.
/// {@endtemplate}
abstract class TodosApi {
  // ignore: public_member_api_docs
  const TodosApi();

  Stream<List<Todo>> getTodos();

  Future<void> saveTodo(Todo todo);

  Future<void> deleteTodo(String id);

  Future<int> clearCompleted();

  Future<int> completeAll({required bool isComplete});
}

// Error when a given id for a todo is not found
class NotFoundException implements Exception {}
