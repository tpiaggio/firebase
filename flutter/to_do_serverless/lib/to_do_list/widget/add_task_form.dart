import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  File? taskImage;

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
            if (taskImage == null)
              _buildAddImageButton()
            else
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Image.file(taskImage!),
              ),
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

  Widget _buildAddImageButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.image, color: Colors.black),
        style: _buildButtonStyle(),
        onPressed: _pickImageFromGallery,
        label: const Text(
          'Add image',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  void _pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      taskImage = File(pickedFile!.path);
    });
  }

  Widget _buildAddButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
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
      userId: FirebaseAuthService.getCurrentUser().uid,
      taskImage: taskImage,
    );
    Navigator.of(context).pop();
  }

  ButtonStyle _buildButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      minimumSize: MaterialStateProperty.all(
        const Size(
          double.infinity,
          56,
        ),
      ),
      backgroundColor: MaterialStateProperty.all<Color>(
        Colors.white,
      ),
    );
  }
}
