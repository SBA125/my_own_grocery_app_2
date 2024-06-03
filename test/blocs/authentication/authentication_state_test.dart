import 'package:flutter_test/flutter_test.dart';
import 'package:my_own_grocery_app_2/blocs/authentication/authentication_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  group('AuthenticationState tests', () {
    test('AuthenticationInitial should have no props', () {
      final authenticationInitial = AuthenticationInitial();
      expect(authenticationInitial.props, []);
    });

    // test('AuthenticationAuthenticated should contain user and role', () {
    //   final user = User(uid: 'uid', email: 'test@example.com');
    //   const role = 'user';
    //   final authenticationAuthenticated = AuthenticationAuthenticated(user, role);
    //   expect(authenticationAuthenticated.props, [user, role]);
    // });

    test('AuthenticationUnauthenticated should have no props', () {
      final authenticationUnauthenticated = AuthenticationUnauthenticated();
      expect(authenticationUnauthenticated.props, []);
    });

    test('AuthenticationLoading should have no props', () {
      final authenticationLoading = AuthenticationLoading();
      expect(authenticationLoading.props, []);
    });

    test('AuthenticationError should contain message', () {
      const errorMessage = 'Error message';
      const authenticationError = AuthenticationError(errorMessage);
      expect(authenticationError.props, [errorMessage]);
    });
  });
}
