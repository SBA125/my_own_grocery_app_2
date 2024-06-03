import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:my_own_grocery_app_2/models/user.dart';
import 'package:my_own_grocery_app_2/services/firebase_user_service.dart';

class MockFirebaseAuth extends Mock implements auth.FirebaseAuth {}
class MockUser extends Mock implements auth.User {}

void main() {
  late FirebaseUserService userService;
  late FakeFirebaseFirestore fakeFirestore;
  late MockFirebaseAuth mockFirebaseAuth;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    mockFirebaseAuth = MockFirebaseAuth();
    userService = FirebaseUserService(firestore: fakeFirestore, firebaseAuth: mockFirebaseAuth);
  });

  test('adds user to database', () async {
    final user = User(userID: 'test-uid' , username: 'Test User', email: 'test@example.com', role: 'user');
    await userService.addUserToDatabase(user);

    final docSnapshot = await fakeFirestore.collection('Users').doc('allUsers').get();
    expect(docSnapshot.exists, true);

    final usersList = (docSnapshot.data()?['usersList'] as List).cast<Map<String, dynamic>>();
    expect(usersList.length, 1);
    expect(usersList.first['userID'], user.userID);
  });

  test('gets user role', () async {
    final user = User(userID: 'test-uid', username: 'Test User', email: 'test@example.com', role: 'user');
    await userService.addUserToDatabase(user);

    final role = await userService.getUserRole('test-uid');
    expect(role, 'user');
  });

  test('displays user details', () async {
    final user = User(userID: 'test-uid', username: 'Test User', email: 'test@example.com', role: 'user');
    await userService.addUserToDatabase(user);
    final fetchedUser = await userService.displayUserDetails();
    expect(fetchedUser.userID, user.userID);
    expect(fetchedUser.email, user.email);
    expect(fetchedUser.username, user.username);
    expect(fetchedUser.role, user.role);
  });
}
