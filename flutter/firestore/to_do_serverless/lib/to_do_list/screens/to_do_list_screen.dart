import 'package:flutter/material.dart';
import 'package:to_do_serverless/to_do_list/widget/add_task_form.dart';
import 'package:to_do_serverless/to_do_list/widget/task_card.dart';
import 'package:to_do_serverless/to_do_list/widget/to_do_list.dart';

class ToDoListScreen extends StatelessWidget {
  const ToDoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: const Text(
          'To Do Serverless',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        actions: [_buildAddButton(context)],
      ),
      body: const ToDoList(),
    );
  }

  IconButton _buildAddButton(BuildContext context) {
    return IconButton(
      onPressed: () => showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (context) => AddTaskForm(),
      ),
      icon: const Icon(Icons.add, color: Colors.black),
    );
  }
}
