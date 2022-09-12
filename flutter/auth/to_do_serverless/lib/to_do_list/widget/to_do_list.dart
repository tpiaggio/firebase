import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_serverless/auth/logic/firebase_auth_service.dart';
import 'package:to_do_serverless/to_do_list/logic/firestore_service.dart';
import 'package:to_do_serverless/to_do_list/widget/task_card.dart';

class ToDoList extends StatelessWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirestoreService.listenTasks(
            userId: FirebaseAuthService.getCurrentUser().uid),
        builder: (context, snapshots) {
          if (snapshots.hasData && snapshots.data != null) {
            final tasks = snapshots.data!.docs;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  task: tasks[index].data(),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
