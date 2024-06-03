import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_own_grocery_app_2/main.dart';
import 'package:my_own_grocery_app_2/repositories/authentication_repository.dart';
import 'package:my_own_grocery_app_2/repositories/order_repository.dart';
import 'package:my_own_grocery_app_2/repositories/user_repository.dart';
import 'package:my_own_grocery_app_2/screens/user/order_history.dart';
import 'package:my_own_grocery_app_2/widgets/side_drawer.dart';


class MockAuthenticationRepository extends Mock implements AuthenticationRepository {}
class MockUserRepository extends Mock implements UserRepository {}
class MockOrderRepository extends Mock implements OrderRepository {}

void main() {
  late AuthenticationRepository authenticationRepository;
  late UserRepository userRepository;
  late OrderRepository orderRepository;

  setUp(() {
    authenticationRepository = MockAuthenticationRepository();
    userRepository = MockUserRepository();
    orderRepository = MockOrderRepository();
  });

  testWidgets('SideDrawer displays user profile and logout buttons', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          drawer: SideDrawer(
            authenticationRepository: authenticationRepository,
            userRepository: userRepository,
            orderRepository: orderRepository,
          ),
        ),
      ),
    );


    expect(find.text('View Profile'), findsOneWidget);
    await tester.tap(find.text('View Profile'));
    await tester.pumpAndSettle();
    expect(find.byType(OrderHistory), findsOneWidget);
    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();
    expect(find.byType(MainScreen), findsOneWidget);
  });

}
