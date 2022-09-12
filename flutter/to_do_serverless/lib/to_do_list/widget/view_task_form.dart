import 'package:flutter/material.dart';
import 'package:to_do_serverless/to_do_list/logic/firestore_service.dart';

class ViewTaskForm extends StatelessWidget {
  ViewTaskForm({
    Key? key,
    required this.task,
  }) : super(key: key) {
    _nameController.text = task['name'];
    _descriptionController.text = task['description'];
  }

  final Map<String, dynamic> task;
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
            if (task['image'] != null) _buildTaskImage(),
            _buildCloseButton(context),
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
        'View task',
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  Padding _buildNameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: TextField(
        readOnly: true,
        controller: _nameController,
        onChanged: (value) => _nameController.text = value,
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
        readOnly: true,
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

  Widget _buildTaskImage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Image.network(task['image']),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text(
          'Close',
        ),
      ),
    );
  }
}
