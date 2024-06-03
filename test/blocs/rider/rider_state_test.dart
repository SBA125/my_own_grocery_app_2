import 'package:flutter_test/flutter_test.dart';
import 'package:my_own_grocery_app_2/blocs/rider/rider_state.dart';
import 'package:my_own_grocery_app_2/models/order.dart';
void main() {
  group('RiderState', () {
    final order = Order(
      id: '123',
      items: [], // Add other properties as needed
      total: 0.0,
      createdAt: DateTime.now(),
      paymentMethod: 'Cash',
      userId: 'user1',
      userName: 'User',
      contactNo: '1234567890',
      address: '123 Street',
      status: 'Pending',
      isReview: false,
    );

    test('RiderInitial supports value comparison', () {
      expect(RiderInitial(),  RiderInitial());
    });

    test('RiderOrderLoading supports value comparison', () {
      expect( RiderOrderLoading(), RiderOrderLoading());
    });

    test('RiderLoadedOrders supports value comparison', () {
      expect(RiderLoadedOrders([order]), RiderLoadedOrders([order]));
    });

    test('RiderAvailable supports value comparison', () {
      expect( RiderAvailable(), RiderAvailable());
    });

    test('RiderUnavailable supports value comparison', () {
      expect(RiderUnavailable(), RiderUnavailable());
    });

    test('RiderError supports value comparison', () {
      expect(const RiderError('error'), const RiderError('error'));
    });

    test('OrderAccepted supports value comparison', () {
      expect(OrderAccepted(order), OrderAccepted(order));
    });

    test('OrderCompleted supports value comparison', () {
      expect(OrderCompleted(order), OrderCompleted(order));
    });
  });
}
