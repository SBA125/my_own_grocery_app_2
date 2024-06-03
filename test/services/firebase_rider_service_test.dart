import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_own_grocery_app_2/services/firebase_rider_service.dart';
import 'package:my_own_grocery_app_2/models/order.dart' as userOrder;

class MockFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late FirebaseRiderService riderService;
  late FakeFirebaseFirestore fakeFirestore;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    riderService = FirebaseRiderService(firestore: fakeFirestore);
  });

  test('get all orders', () async {
    // Add some sample orders to Firestore
    final ordersCollection = fakeFirestore.collection('Orders');
    await ordersCollection.doc('order1').set({'orderData': 'order1 data'});
    await ordersCollection.doc('order2').set({'orderData': 'order2 data'});

    // Retrieve orders using the service
    final orders = await riderService.getAllOrders();

    // Verify that the correct number of orders is retrieved
    expect(orders.length, 2);
  });

  // test('get order by ID', () async {
  //   // Add a sample order to Firestore
  //   final ordersCollection = fakeFirestore.collection('Orders');
  //   const orderId = 'sampleOrderId';
  //   await ordersCollection.doc(orderId).set({'orderData': 'sample order data'});
  //
  //   // Retrieve the order using the service
  //   final order = await riderService.getOrder(orderId);
  //
  //   // Verify that the correct order is retrieved
  //   expect(order.orderData, 'sample order data');
  // });
}
