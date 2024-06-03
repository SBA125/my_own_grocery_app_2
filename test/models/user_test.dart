import 'package:flutter_test/flutter_test.dart';
import 'package:my_own_grocery_app_2/models/user.dart';


void main() {
  group('User', () {
    test('fromMap should correctly parse a map to a User object', () {
      final Map<String, dynamic> userData = {
        'userID': '123',
        'username': 'testuser',
        'email': 'test@example.com',
        'role': 'user',
      };

      final user = User.fromMap(userData);

      expect(user.userID, '123');
      expect(user.username, 'testuser');
      expect(user.email, 'test@example.com');
      expect(user.role, 'user');
    });

    test('toMap should correctly serialize a User object to a map', () {
      final user = User(
        userID: '123',
        username: 'testuser',
        email: 'test@example.com',
        role: 'user',
      );

      final userData = user.toMap();

      expect(userData['userID'], '123');
      expect(userData['username'], 'testuser');
      expect(userData['email'], 'test@example.com');
      expect(userData['role'], 'user');
    });
  });
}
