import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:to_do_serverless/auth/logic/firebase_auth_service.dart';
import 'package:to_do_serverless/auth/screen/login_screen.dart';
import 'package:to_do_serverless/auth/screen/sign_up_screen.dart';
import 'package:to_do_serverless/to_do_list/logic/firestore_service.dart';
import 'package:to_do_serverless/to_do_list/widget/add_task_form.dart';
import 'package:to_do_serverless/to_do_list/widget/task_card.dart';
import 'package:to_do_serverless/to_do_list/widget/to_do_list.dart';
import 'package:to_do_serverless/to_do_list/widget/view_task_form.dart';

class ToDoListScreen extends StatefulWidget {
  ToDoListScreen({Key? key}) : super(key: key);

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    FirebaseDynamicLinks.instance.onLink.listen((pendingLink) {
      final link = pendingLink.link;
      _triggerLink(link);
    });

    FirebaseDynamicLinks.instance.getInitialLink().then((initialLink) {
      final link = initialLink?.link;
      if (link != null) {
        _triggerLink(link);
      }
    });
  }

  void _triggerLink(Uri link) async {
    if (FirebaseAuthService.getCurrentUser() != null) {
      _showTask(link.queryParameters['taskId']!);
    }
  }

  void _showTask(String taskId) async {
    final task = await FirestoreService.getTask(taskId);

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
        task: task!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0.5,
        title: const Text(
          'To Do Serverless',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        actions: [
          _buildAddButton(context),
          _buildLogOutButton(context),
        ],
      ),
      body: const ToDoList(),
    );
  }

  IconButton _buildAddButton(BuildContext context) {
    return IconButton(
      onPressed: () => scaffoldKey.currentState!.showBottomSheet(
        (context) => AddTaskForm(),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),
      icon: const Icon(Icons.add, color: Colors.black),
    );
  }

  IconButton _buildLogOutButton(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await FirebaseAuthService.logOut();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      },
      icon: const Icon(Icons.logout, color: Colors.black),
    );
  }
}
