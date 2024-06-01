import 'package:firebase_auth/firebase_auth.dart';

import '../services/firebase_auth_service.dart';

class AuthenticationRepository {
  final FirebaseAuthService _authService;

  AuthenticationRepository(this._authService);

  Future<User?> signInWithGoogle() async {
    try {
      User? user = await _authService.signInWithGoogle();
      return user;
    } catch (e) {
      print("Error signing in with Google: $e");
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) {
    return _authService.signInWithEmailAndPassword(email, password);
  }

  Future<User?> signUpWithEmailAndPassword(String email, String password, String username) {
    return _authService.signUpWithEmailAndPassword(email, password, username);
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}
