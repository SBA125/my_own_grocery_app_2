import 'package:firebase_auth/firebase_auth.dart';

import '../services/firebase_auth_service.dart';

class AuthenticationRepository {
  final FirebaseAuthService _authService;

  AuthenticationRepository(this._authService);

  Future<User?> signInWithEmailAndPassword(String email, String password) {
    return _authService.signInWithEmailAndPassword(email, password);
  }

  Future<User?> signUpWithEmailAndPassword(String email, String password) {
    return _authService.signUpWithEmailAndPassword(email, password);
  }

  Future<void> signOut() {
    return _authService.signOut();
  }
}
