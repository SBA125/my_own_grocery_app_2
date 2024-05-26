import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import '../services/firebase_user_service.dart';

class UserRepository {
  final FirebaseUserService firebaseUserService;

  UserRepository({required this.firebaseUserService});

  Future<void> addUser(User user) async {
    await firebaseUserService.addUserToDatabase(user);
  }
}

