import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_cubit/models/todo_model.dart';

class TodoCubit extends Cubit<List<TodoModel>> {
  TodoCubit() : super([]);

  void add(String title) {
    if (title.isEmpty) {
      addError('Title is empty');
      return;
    }
    final todo = TodoModel(
      name: title,
      createdAt: DateTime.now(),
    );
    state.add(todo);
    emit(List.from(state));
    // emit([...state, todo]);
  }

  @override
  void onChange(Change<List<TodoModel>> change) {
    super.onChange(change);
    log('TodoCubit -> $change');
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    log('TodoCubit -> $error', stackTrace: stackTrace);
    super.onError(error, stackTrace);
  }
}
