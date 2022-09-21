import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<User?> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    final UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userCredential.user?.updateDisplayName(name);
    return userCredential.user;
  }

  static Future<User?> logIn({
    required String email,
    required String password,
  }) async {
    final UserCredential userCredential =
        await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  static Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  static User getCurrentUser() {
    return _firebaseAuth.currentUser!;
  }
}
