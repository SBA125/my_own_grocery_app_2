import 'package:flutter_test/flutter_test.dart';
import 'package:my_own_grocery_app_2/blocs/orders/order_event.dart';
import 'package:my_own_grocery_app_2/models/order.dart';

void main() {
  group('PlaceOrder', () {
    test('props are correct', () {
      final order = Order(
        id: '1',
        items: [],
        total: 100,
        createdAt: DateTime.now(),
        paymentMethod: 'Cash',
        userId: 'user123',
        userName: 'John Doe',
        contactNo: '1234567890',
        address: '123 Main St',
        status: 'Pending',
        isReview: false,
      );
      final placeOrderEvent = PlaceOrder(order);

      // Verify that props getter returns a list containing the order
      expect(placeOrderEvent.props, [order]);
    });
  });

  group('FetchOrderHistory', () {
    test('props are correct', () {
      const userID = 'user123';
      const fetchOrderHistoryEvent = FetchOrderHistory(userID);

      // Verify that props getter returns a list containing the user ID
      expect(fetchOrderHistoryEvent.props, [userID]);
    });
  });

  group('ChangeOrderStatus', () {
    test('props are correct', () {
      const orderId = '1';
      const newStatus = 'Completed';
      final changeOrderStatusEvent = ChangeOrderStatus(orderId, newStatus);

      // Verify that props getter returns a list containing the order ID and new status
      expect(changeOrderStatusEvent.props, [orderId, newStatus]);
    });
  });
}