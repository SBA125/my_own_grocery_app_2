import 'package:flutter_test/flutter_test.dart';
import 'package:my_own_grocery_app_2/blocs/admin/admin_state.dart';
import 'package:my_own_grocery_app_2/models/user.dart';
import 'package:my_own_grocery_app_2/models/product.dart';
import 'package:my_own_grocery_app_2/models/category.dart';
import 'package:my_own_grocery_app_2/models/order.dart';
import 'package:my_own_grocery_app_2/models/rider.dart';
import 'package:my_own_grocery_app_2/models/review.dart';

void main() {
  group('AdminState tests', () {
    test('AdminInitial should have no props', () {
      final adminInitial = AdminInitial();
      expect(adminInitial.props, []);
    });

    test('AdminLoading should have no props', () {
      final adminLoading = AdminLoading();
      expect(adminLoading.props, []);
    });

    test('AdminLoadedUsers should contain the users list', () {
      final users = [User(userID: '1', username: 'User 1', email: 'user1@example.com', role: 'user')];
      final adminLoadedUsers = AdminLoadedUsers(users);
      expect(adminLoadedUsers.props, [users]);
    });

    test('AdminLoadedProducts should contain the products list', () {
      final products = [Product(productID: '1', name: 'Product 1', description: 'Description 1', price: 10, imageUrl: 'image_url', quantity: 10, inStock: true)];
      final adminLoadedProducts = AdminLoadedProducts(products);
      expect(adminLoadedProducts.props, [products]);
    });

    test('AdminLoadedCategories should contain the categories list', () {
      final categories = [Category(categoryID: '1', name: 'Category 1', imageUrl: 'image_url', productIDs: ['1', '2'])];
      final adminLoadedCategories = AdminLoadedCategories(categories);
      expect(adminLoadedCategories.props, [categories]);
    });

    test('AdminLoadedOrders should contain the orders list', () {
      final orders = [Order(id: '1', items: [], total: 10, createdAt: DateTime.now(), paymentMethod: 'cash', userId: '1', userName: 'User 1', contactNo: '123456', address: 'Address 1', status: 'pending', isReview: false)];
      final adminLoadedOrders = AdminLoadedOrders(orders);
      expect(adminLoadedOrders.props, [orders]);
    });

    // test('AdminLoadedRiders should contain the riders list', () {
    //   final riders = [Rider(riderID: '1', name: 'Rider 1', email: 'rider1@example.com', phoneNumber: '123456', status: 'active', userID: '')];
    //   final adminLoadedRiders = AdminLoadedRiders(riders);
    //   expect(adminLoadedRiders.props, [riders]);
    // });

    test('AdminLoadedReviews should contain the reviews list', () {
      final reviews = [Review(reviewID: '1', orderID: '1', createdAt: DateTime.now(), rating: '5', additionalNotes: 'Great product')];
      final adminLoadedReviews = AdminLoadedReviews(reviews);
      expect(adminLoadedReviews.props, [reviews]);
    });

    test('AdminSuccess should have no props', () {
      final adminSuccess = AdminSuccess();
      expect(adminSuccess.props, []);
    });

    test('AdminFailure should contain the error message', () {
      const errorMessage = 'Error message';
      const adminFailure = AdminFailure(errorMessage);
      expect(adminFailure.props, [errorMessage]);
    });
  });
}
