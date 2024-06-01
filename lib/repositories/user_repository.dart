import '../models/user.dart';
import '../services/firebase_user_service.dart';

class UserRepository {
  final FirebaseUserService firebaseUserService;

  UserRepository({required this.firebaseUserService});

  Future<void> addUser(User user) async {
    await firebaseUserService.addUserToDatabase(user);
  }

  Future<String> getUserRole(String userID) async{
    return await firebaseUserService.getUserRole(userID);
  }

  Future<User> displayUserDetails() async{
    return await firebaseUserService.displayUserDetails();
  }
}

