
import 'package:flutter_test/flutter_test.dart';
import 'package:my_own_grocery_app_2/blocs/authentication/authentication_event.dart';

void main() {
  group('AuthenticationEvent tests', () {
    test('AuthenticationStart should have no props', () {
      final authenticationStart = AuthenticationStart();
      expect(authenticationStart.props, []);
    });

    test('AuthenticationSignInRequested should contain email and password', () {
      const email = 'test@example.com';
      const password = 'password';
      const authenticationSignInRequested = AuthenticationSignInRequested(email: email, password: password);
      expect(authenticationSignInRequested.props, [email, password]);
    });

    test('AuthenticationSignUpRequested should contain email, password, and username', () {
      const email = 'test@example.com';
      const password = 'password';
      const username = 'username';
      const authenticationSignUpRequested = AuthenticationSignUpRequested(email: email, password: password, username: username);
      expect(authenticationSignUpRequested.props, [email, password, username]);
    });

    test('AuthenticationSignOutRequested should have no props', () {
      const authenticationSignOutRequested = AuthenticationSignOutRequested();
      expect(authenticationSignOutRequested.props, []);
    });

    // Add tests for other events similarly
  });
}
