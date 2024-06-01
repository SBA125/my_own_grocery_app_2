import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../models/user.dart';

class FirebaseUserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUserToDatabase(User user) async {
    try {
      await _firestore.runTransaction((transaction) async {
        final allUsersDoc = _firestore.collection('Users').doc('allUsers');

        // Ensure the 'allUsers' document exists
        final docSnapshot = await transaction.get(allUsersDoc);
        if (!docSnapshot.exists) {
          await transaction.set(allUsersDoc, {'usersList': []});
        }

        // Retrieve the current 'usersList' array from the document
        final List<dynamic> usersList = docSnapshot.data()?['usersList'] ?? [];

        // Append the user information to the 'usersList' array
        usersList.add({
          'userID': user.userID,
          'email': user.email,
          'username': user.username,
          'role': 'user'
          // Add other user fields if necessary
        });

        // Update the document with the modified 'usersList'
        transaction.update(allUsersDoc, {'usersList': usersList});
      });
    } catch (e) {
      throw Exception('Failed to add user to database: $e');
    }
  }

  Future<String> getUserRole(String userID) async {
    final doc = await _firestore.collection('Users').doc('allUsers').get();
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

  Future<User> displayUserDetails() async{
    final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
    final auth.User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      final DocumentSnapshot userDocSnapshot = await _firestore.collection('Users').doc('allUsers').get();

      if (userDocSnapshot.exists) {
        final Map<String, dynamic>? userDataMap = userDocSnapshot.data() as Map<String, dynamic>?; // Cast to Map<String, dynamic>?
        final List<dynamic> usersList = userDataMap?['usersList'] ?? [];
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


