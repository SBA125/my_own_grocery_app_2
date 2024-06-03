import 'package:flutter_test/flutter_test.dart';
import 'package:my_own_grocery_app_2/models/cart.dart';
import 'package:my_own_grocery_app_2/models/order.dart';


void main() {
  group('Order', () {
    test('Properties should be set correctly', () {
      final String id = '1';
      final List<CartItem> items = [
        CartItem(id: '123', productId: '1', name: 'Product 1', price: 10, quantity: 2, imageUrl: 'image1.jpg'),
        CartItem(id: '456', productId: '2', name: 'Product 2', price: 20, quantity: 1, imageUrl: 'image2.jpg'),
      ];
      final double total = 50.0;
      final DateTime createdAt = DateTime.now();
      final String paymentMethod = 'Cash';
      final String userId = 'user123';
      final String userName = 'John Doe';
      final String contactNo = '1234567890';
      final String address = '123 Main St';
      final String status = 'Pending';
      final bool isReview = false;

      final order = Order(
        id: id,
        items: items,
        total: total,
        createdAt: createdAt,
        paymentMethod: paymentMethod,
        userId: userId,
        userName: userName,
        contactNo: contactNo,
        address: address,
        status: status,
        isReview: isReview,
      );

      expect(order.id, id);
      expect(order.items, items);
      expect(order.total, total);
      expect(order.createdAt, createdAt);
      expect(order.paymentMethod, paymentMethod);
      expect(order.userId, userId);
      expect(order.userName, userName);
      expect(order.contactNo, contactNo);
      expect(order.address, address);
      expect(order.status, status);
      expect(order.isReview, isReview);
    });

    test('copyWith should create a new instance with updated values', () {
      final order = Order(
        id: '1',
        items: [],
        total: 0.0,
        createdAt: DateTime.now(),
        paymentMethod: '',
        userId: '',
        userName: '',
        contactNo: '',
        address: '',
        status: 'Pending',
        isReview: false,
      );

      final updatedOrder = order.copyWith(status: 'Completed', isReview: true);

      expect(updatedOrder.status, 'Completed');
      expect(updatedOrder.isReview, true);
      expect(updatedOrder.id, order.id);
      expect(updatedOrder.items, order.items);
      expect(updatedOrder.total, order.total);
      expect(updatedOrder.createdAt, order.createdAt);
      expect(updatedOrder.paymentMethod, order.paymentMethod);
      expect(updatedOrder.userId, order.userId);
      expect(updatedOrder.userName, order.userName);
      expect(updatedOrder.contactNo, order.contactNo);
      expect(updatedOrder.address, order.address);
    });

    test('toMap should return a map representation of the object', () {
      final order = Order(
        id: '1',
        items: [],
        total: 0.0,
        createdAt: DateTime.now(),
        paymentMethod: '',
        userId: '',
        userName: '',
        contactNo: '',
        address: '',
        status: 'Pending',
        isReview: false,
      );

      final map = order.toMap();

      expect(map['id'], order.id);
      expect(map['items'], isEmpty);
      expect(map['total'], order.total);
      expect(map['createdAt'], order.createdAt);
      expect(map['paymentMethod'], order.paymentMethod);
      expect(map['userId'], order.userId);
      expect(map['userName'], order.userName);
      expect(map['contactNo'], order.contactNo);
      expect(map['address'], order.address);
      expect(map['status'], order.status);
      expect(map['isReview'], order.isReview);
    });

    test('fromMap should create an instance from a map', () {
      final data = {
        'id': '1',
        'items': [],
        'total': 0.0,
        'createdAt': DateTime.now(),
        'paymentMethod': '',
        'userId': '',
        'userName': '',
        'contactNo': '',
        'address': '',
        'status': 'Pending',
        'isReview': false,
      };

      final order = Order.fromMap(data, '1');

      expect(order.id, '1');
      expect(order.items, isEmpty);
      expect(order.total, 0.0);
      expect(order.paymentMethod, '');
      expect(order.userId, '');
      expect(order.userName, '');
      expect(order.contactNo, '');
      expect(order.address, '');
      expect(order.status, 'Pending');
      expect(order.isReview, false);
    });
  });
}
