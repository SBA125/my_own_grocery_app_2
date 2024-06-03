import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../models/user.dart';

class FirebaseUserService {
  final FirebaseFirestore firestore;
  final auth.FirebaseAuth firebaseAuth;

  FirebaseUserService({
    required this.firestore,
    required this.firebaseAuth,
  });

  Future<void> addUserToDatabase(User user) async {
    try {
      await firestore.runTransaction((transaction) async {
        final allUsersDoc = firestore.collection('Users').doc('allUsers');

        // Ensure the 'allUsers' document exists
        final docSnapshot = await transaction.get(allUsersDoc);
        if (!docSnapshot.exists) {
          await transaction.set(allUsersDoc, {'usersList': []});
        }

        final List<dynamic> usersList = docSnapshot.data()?['usersList'] ?? [];

        usersList.add({
          'userID': user.userID,
          'email': user.email,
          'username': user.username,
          'role': 'user',
        });

        transaction.update(allUsersDoc, {'usersList': usersList});
      });
    } catch (e) {
      throw Exception('Failed to add user to database: $e');
    }
  }

  Future<String> getUserRole(String userID) async {
    final doc = await firestore.collection('Users').doc('allUsers').get();
    if (doc.exists) {
      final usersList = doc.data()?['usersList'] ?? [];
      final userData = usersList.firstWhere((user) => user['userID'] == userID, orElse: () => null);
      if (userData != null) {
        return userData['role'] ?? 'user';
      } else {
        return 'user';
      }
    } else {
      return 'user';
    }
  }

  Future<User> displayUserDetails() async {
    final currentUser = firebaseAuth.currentUser;

    if (currentUser != null) {
      final userDocSnapshot = await firestore.collection('Users').doc('allUsers').get();

      if (userDocSnapshot.exists) {
        final userDataMap = userDocSnapshot.data() as Map<String, dynamic>?;
        final usersList = userDataMap?['usersList'] ?? [];
        final userData = usersList.firstWhere((user) => user['userID'] == currentUser.uid, orElse: () => null);

        if (userData != null) {
          return User(
            userID: userData['userID'],
            username: userData['username'],
            email: userData['email'],
            role: userData['role'] ?? 'user',
          );
        } else {
          final newUser = User(
            userID: currentUser.uid.toString(),
            username: currentUser.displayName ?? 'Unknown',
            email: currentUser.email ?? 'Unknown',
            role: 'user',
          );
          await addUserToDatabase(newUser);
          return newUser;
        }
      } else {
        throw Exception('No users document found');
      }
    }
    throw Exception('No user is currently authenticated or user details not found');
  }
}