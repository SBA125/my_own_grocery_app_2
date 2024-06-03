import 'package:flutter_test/flutter_test.dart';
import 'package:my_own_grocery_app_2/blocs/rider/rider_event.dart';
import 'package:my_own_grocery_app_2/models/order.dart';

void main() {
  group('AcceptOrder', () {
    test('props are correct', () {
      final order = Order(
        id: '12345', items: [],
        total: 255,
        createdAt: DateTime.now(),
        paymentMethod: 'cash on delivery',
        userId: '1',
        userName: 'Syed Bilal Ali',
        contactNo: '03362418015',
        address: 'address',
        status: 'pending',
        isReview: false,
      );

      // Create the AcceptOrder event with the sample order
      final acceptOrderEvent = AcceptOrder(order);

      // Verify that props getter returns a list containing the order
      expect(acceptOrderEvent.props, [order]);
    });
  });
}
