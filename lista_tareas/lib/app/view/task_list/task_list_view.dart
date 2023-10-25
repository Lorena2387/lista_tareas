// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lista_tareas/app/models/task.dart';
//import 'package:lista_tareas/app/repository/task_repository.dart';
import 'package:lista_tareas/app/view/components/h1.dart';
import 'package:lista_tareas/app/view/components/shape.dart';
import 'package:lista_tareas/app/view/task_list/task_provider.dart';
import 'package:provider/provider.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider()..fetchTask(),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _Header(),
            Expanded(
              child: _TaskList(),
            ),
          ],
        ),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () => _showNewTaskModal(context),
            child: const Icon(Icons.add),
          );
        }),
      ),
    );
  }

  void _showNewTaskModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => ChangeNotifierProvider.value(
              value: context.read<TaskProvider>(),
              child: _NewTaskModal(),
            ));
  }
}

class _NewTaskModal extends StatelessWidget {
  _NewTaskModal({
    super.key,
  });

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 33, vertical: 23),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(21)),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          H1('Nueva tarea'),
          SizedBox(
            height: 26,
          ),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              hintText: 'Descripción de la tarea',
            ),
          ),
          SizedBox(
            height: 26,
          ),
          ElevatedButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                final task = Task(_controller.text);
                context.read<TaskProvider>().addNewTask(task);
                Navigator.of(context).pop();
              }
            },
            child: const Text(
              'Guardar',
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskList extends StatelessWidget {
  const _TaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 25,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const H1(
            'Tareas',
          ),
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (_, provider, __) {
                if (provider.taskList.isEmpty) {
                  return Center(
                    child: Text('No hay tareas'),
                  );
                }
                return ListView.separated(
                    itemBuilder: (_, index) => _TaskItem(
                          provider.taskList[index],
                          onTap: () => provider
                              .onTaskDoneChange(provider.taskList[index]),
                        ),
                    separatorBuilder: (_, __) => SizedBox(
                          height: 16,
                        ),
                    itemCount: provider.taskList.length);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        children: [
          const Row(
            children: [Shape()],
          ),
          Column(
            children: [
              Image.asset(
                'assets/images/lista_chequeo.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(
                height: 16,
              ),
              const H1(
                'Completa tus tareas',
                color: Colors.white,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _TaskItem extends StatelessWidget {
  const _TaskItem(this.task, {super.key, this.onTap});

  final Task task;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(21),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 21,
              vertical: 18,
            ),
            child: Row(
              children: [
                Icon(
                  task.done
                      ? Icons.check_box_rounded
                      : Icons.check_box_outline_blank,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(task.title),
              ],
            ),
          )),
    );
  }
}
