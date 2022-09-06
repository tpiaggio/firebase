import 'package:flutter/material.dart';
import 'package:to_do_serverless/auth/logic/firebase_auth_service.dart';
import 'package:to_do_serverless/to_do_list/logic/firestore_service.dart';

class AddTaskForm extends StatefulWidget {
  AddTaskForm({Key? key}) : super(key: key);

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
            _buildAddButton(context),
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
        'Add a new task',
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

  Widget _buildAddButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: 16.0 + MediaQuery.of(context).viewInsets.bottom),
      child: ElevatedButton(
        onPressed: () => addTask(context),
        child: const Text(
          'Add',
        ),
      ),
    );
  }

  Future<void> addTask(BuildContext context) async {
    await FirestoreService.addTask(
        name: _nameController.text,
        description: _descriptionController.text,
        userId: FirebaseAuthService.getCurrentUser().uid);
    Navigator.of(context).pop();
  }
}
