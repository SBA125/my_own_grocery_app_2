import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        return userCredential.user;
      }
    } catch (e) {
      print("Error signing in with Google: $e");
      return null;
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      // Handle sign-in errors
      print('Sign-in error: $e');
      return null;
    }
  }

  Future<User?> signUpWithEmailAndPassword(String email, String password, String username) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update the user's display name with the provided username
      await userCredential.user?.updateDisplayName(username);
      await userCredential.user?.reload(); // Refresh the user's profile

      // Save user details to Firestore
      await _firestore.collection('Users').doc('allUsers').update({
        'usersList': FieldValue.arrayUnion([
          {
            'userID': userCredential.user?.uid,
            'email': email,
            'username': username,
            'role': 'user',
          }
        ])
      });

      return userCredential.user;
    } catch (e) {
      // Handle sign-up errors
      print('Sign-up error: $e');
      return null;
    }
  }


  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      // Handle sign-out errors
      print('Sign-out error: $e');
    }
  }
}
