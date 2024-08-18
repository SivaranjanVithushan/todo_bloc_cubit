import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_cubit/cubit/todo_cubit.dart';
import 'package:todo_bloc_cubit/models/todo_model.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
      ),
      body: BlocBuilder<TodoCubit, List<TodoModel>>(
        builder: (context, todoList) {
          return ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              final todo = todoList[index];
              return ListTile(
                title: Text(todo.name),
                subtitle: Text(todo.createdAt.toString()),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.pushNamed(context, '/add-todo');
          showDialog(context: context, builder: (_) => const AddTodoDialog());
        },
        tooltip: "Add Todo",
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddTodoDialog extends StatelessWidget {
  const AddTodoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final todoTitleController = TextEditingController();
    return AlertDialog(
      title: const Text("Add Todo"),
      content: TextField(
        controller: todoTitleController,
        decoration: const InputDecoration(hintText: 'Title'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            todoCubit.add(todoTitleController.text);
            Navigator.pop(context);
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
