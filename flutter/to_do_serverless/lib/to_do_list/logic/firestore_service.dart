import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FirestoreService {
  static final _firestore = FirebaseFirestore.instance;

  static Future<void> addTask({
    required String name,
    required String description,
    required String userId,
  }) async {
    // await _firestore.collection('tasks').add({
    //   'name': name,
    //   'description': description,
    //   'created_at': DateTime.now().toIso8601String(),
    // });

    // OR
    final taskDoc = _firestore.collection('tasks').doc();
    return taskDoc.set({
      'id': taskDoc.id,
      'name': name,
      'description': description,
      'created_at': DateTime.now().toIso8601String(),
      'userId': userId,
    });
  }

  static Future<Map<String, dynamic>?> getTask(String id) async {
    final task = await _firestore.collection('tasks').doc(id).get();
    return task.data();
  }

  static Future<Map<String, dynamic>?> updateTask({
    required String id,
    required String name,
    required String description,
  }) async {
    final task = await _firestore.collection('tasks').doc(id).update({
      'name': name,
      'description': description,
    });
  }

  static Future<void> deleteTask({
    required String id,
  }) async {
    await _firestore.collection('tasks').doc(id).delete();
  }

  static Future<List<Map<String, dynamic>>> getTasks(
      {required String userId}) async {
    final tasks = await _firestore
        .collection('tasks')
        .where('userId', isEqualTo: userId)
        .get();
    return tasks.docs.map((e) => e.data()).toList();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> listenTasks({
    required String userId,
  }) {
    return _firestore
        .collection('tasks')
        .where('userId', isEqualTo: userId)
        .snapshots();
  }
}
