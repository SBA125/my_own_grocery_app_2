import 'package:flutter_test/flutter_test.dart';
import 'package:my_own_grocery_app_2/blocs/users/user_event.dart';


void main() {
  group('UserEvent', () {
    test('FetchUserDetails supports value comparison', () {
      expect( FetchUserDetails(), FetchUserDetails());
    });
  });
}
