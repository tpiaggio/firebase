import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<String> uploadTaskImage({
    required String taskId,
    required File image,
  }) async {
    final storageRef = _storage.ref();
    final taskImageRef = storageRef.child('task_images/${taskId}');
    final uploadTask = taskImageRef.putFile(image);
    final snapshot = await uploadTask;
    final url = await snapshot.ref.getDownloadURL();
    return url;
  }
}
