import 'package:flutter/material.dart';
import 'package:to_do_serverless/to_do_list/logic/firestore_service.dart';
import 'package:to_do_serverless/to_do_list/widget/edit_task_form.dart';
import 'package:to_do_serverless/to_do_list/widget/view_task_form.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({Key? key, required this.task, required}) : super(key: key);

  final Map<String, dynamic> task;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showTask(context),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            task['name'],
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 18),
          ),
        )),
        _buildEditButton(context),
        _buildDeleteButton(),
      ]),
    );
  }

  void showTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) => ViewTaskForm(
        task: task,
      ),
    );
  }

  IconButton _buildEditButton(BuildContext context) {
    return IconButton(
      onPressed: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (context) => EditTaskForm(
          task: task,
        ),
      ),
      icon: const Icon(Icons.edit),
    );
  }

  IconButton _buildDeleteButton() {
    return IconButton(
      onPressed: () => FirestoreService.deleteTask(id: task['id']),
      icon: const Icon(Icons.delete),
    );
  }
}
