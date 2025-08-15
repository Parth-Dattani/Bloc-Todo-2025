import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> login(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Logout function
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}
