

import 'package:flutter_test/flutter_test.dart';
import 'package:my_own_grocery_app_2/blocs/orders/order_state.dart';
import 'package:my_own_grocery_app_2/models/order.dart';

void main() {
  group('OrderInitial', () {
    test('props are correct', () {
      const orderInitial = OrderInitial();

      // Verify that props getter returns an empty list
      expect(orderInitial.props, []);
    });
  });

  group('OrderLoading', () {
    test('props are correct', () {
      const orderLoading = OrderLoading();

      // Verify that props getter returns an empty list
      expect(orderLoading.props, []);
    });
  });

  group('OrderPlaced', () {
    test('props are correct', () {
      const orderPlaced = OrderPlaced();

      // Verify that props getter returns an empty list
      expect(orderPlaced.props, []);
    });
  });

  group('OrderError', () {
    test('props are correct', () {
      const errorMessage = 'Failed to place order';
      const orderError = OrderError(errorMessage);

      // Verify that props getter returns a list containing the error message
      expect(orderError.props, [errorMessage]);
    });
  });

  group('OrderHistoryLoading', () {
    test('props are correct', () {
      const orderHistoryLoading = OrderHistoryLoading();

      // Verify that props getter returns an empty list
      expect(orderHistoryLoading.props, []);
    });
  });

  group('OrderHistoryLoaded', () {
    test('props are correct', () {
      final orders = [
        Order(id: '1', items: [], total: 100, createdAt: DateTime.now(), paymentMethod: 'Cash', userId: 'user123', userName: 'John Doe', contactNo: '1234567890', address: '123 Main St', status: 'Pending', isReview: false),
        Order(id: '2', items: [], total: 150, createdAt: DateTime.now(), paymentMethod: 'Card', userId: 'user456', userName: 'Jane Smith', contactNo: '9876543210', address: '456 Park Ave', status: 'Delivered', isReview: false),
      ];
      final orderHistoryLoaded = OrderHistoryLoaded(orders);

      // Verify that props getter returns a list containing the orders
      expect(orderHistoryLoaded.props, [orders]);
    });
  });

  group('OrderHistoryError', () {
    test('props are correct', () {
      const errorMessage = 'Failed to load order history';
      const orderHistoryError = OrderHistoryError(errorMessage);

      // Verify that props getter returns a list containing the error message
      expect(orderHistoryError.props, [errorMessage]);
    });
  });

  group('OrderStatusChanged', () {
    test('props are correct', () {
      final order = Order(id: '1', items: [], total: 100, createdAt: DateTime.now(), paymentMethod: 'Cash', userId: 'user123', userName: 'John Doe', contactNo: '1234567890', address: '123 Main St', status: 'Completed', isReview: false);
      final orderStatusChanged = OrderStatusChanged(order);

      // Verify that props getter returns a list containing the order
      expect(orderStatusChanged.props, [order]);
    });
  });
}
