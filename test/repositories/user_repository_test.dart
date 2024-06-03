import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_own_grocery_app_2/models/user.dart';
import 'package:my_own_grocery_app_2/repositories/user_repository.dart';
import 'package:my_own_grocery_app_2/services/firebase_user_service.dart';


class MockFirebaseUserService extends Mock implements FirebaseUserService {}

void main() {
  group('UserRepository', () {
    late UserRepository userRepository;
    late MockFirebaseUserService mockFirebaseUserService;

    setUp(() {
      mockFirebaseUserService = MockFirebaseUserService();
      userRepository = UserRepository(firebaseUserService: mockFirebaseUserService);
    });

    test('addUser calls addUserToDatabase from FirebaseUserService', () async {
      // Arrange
      final user = User(userID: '123', email: 'test@example.com', username: 'Test User', role: 'user');
      when(mockFirebaseUserService.addUserToDatabase(user)).thenAnswer((_) async {});

      await userRepository.addUser(user);

      verify(mockFirebaseUserService.addUserToDatabase(user)).called(1);
    });

    test('getUserRole calls getUserRole from FirebaseUserService', () async {
      // Arrange
      const userID = '123';
      const role = 'user';
      when(mockFirebaseUserService.getUserRole(userID)).thenAnswer((_) async => role);

      // Act
      final result = await userRepository.getUserRole(userID);

      // Assert
      expect(result, role);
      verify(mockFirebaseUserService.getUserRole(userID)).called(1);
    });

    test('displayUserDetails calls displayUserDetails from FirebaseUserService', () async {
      // Arrange
      final user = User(userID: '123', email: 'test@example.com', username: 'Test User', role: 'user');
      when(mockFirebaseUserService.displayUserDetails()).thenAnswer((_) async => user);

      // Act
      final result = await userRepository.displayUserDetails();

      // Assert
      expect(result, user);
      verify(mockFirebaseUserService.displayUserDetails()).called(1);
    });
  });
}
