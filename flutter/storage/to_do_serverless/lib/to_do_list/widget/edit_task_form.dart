import 'package:flutter/material.dart';
import 'package:to_do_serverless/to_do_list/logic/firestore_service.dart';

class EditTaskForm extends StatefulWidget {
  EditTaskForm({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Map<String, dynamic> task;

  @override
  State<EditTaskForm> createState() => _EditTaskFormState();
}

class _EditTaskFormState extends State<EditTaskForm> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.task['name'];
    _descriptionController.text = widget.task['description'];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildAddLabel(),
            _buildNameTextField(),
            _buildDescriptionTextField(),
            _buildEditButton(context),
          ],
        ),
      ),
    );
  }

  Padding _buildAddLabel() {
    return const Padding(
      padding: EdgeInsets.only(
        top: 24.0,
      ),
      child: Text(
        'Edit task',
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  Padding _buildNameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: TextField(
        controller: _nameController,
        decoration: const InputDecoration(
          labelText: 'Name',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildDescriptionTextField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: TextField(
        controller: _descriptionController,
        decoration: const InputDecoration(
          labelText: 'Description',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: 16.0 + MediaQuery.of(context).viewInsets.bottom),
      child: ElevatedButton(
        onPressed: () => editTask(context),
        child: const Text(
          'Save',
        ),
      ),
    );
  }

  Future<void> editTask(BuildContext context) async {
    await FirestoreService.updateTask(
        id: widget.task['id'],
        name: _nameController.text,
        description: _descriptionController.text);
    Navigator.of(context).pop();
  }
}
