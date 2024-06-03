import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_own_grocery_app_2/models/review.dart';

void main() {
  group('Review', () {
    test('Properties should be set correctly', () {
      final String reviewID = '1';
      final String orderID = '123';
      final DateTime createdAt = DateTime.now();
      final String rating = '5';
      final String? additionalNotes = 'Great product!';

      final review = Review(
        reviewID: reviewID,
        orderID: orderID,
        createdAt: createdAt,
        rating: rating,
        additionalNotes: additionalNotes,
      );

      expect(review.reviewID, reviewID);
      expect(review.orderID, orderID);
      expect(review.createdAt, createdAt);
      expect(review.rating, rating);
      expect(review.additionalNotes, additionalNotes);
    });

    test('toMap should return a map representation of the object', () {
      final review = Review(
        reviewID: '1',
        orderID: '123',
        createdAt: DateTime.now(),
        rating: '5',
        additionalNotes: 'Great product!',
      );

      final map = review.toMap();

      expect(map['reviewID'], review.reviewID);
      expect(map['orderID'], review.orderID);
      expect(map['createdAt'], review.createdAt);
      expect(map['rating'], review.rating);
      expect(map['additionalNotes'], review.additionalNotes);
    });

    test('fromMap should create an instance from a map', () {
      final data = {
        'reviewID': '1',
        'orderID': '123',
        'createdAt': Timestamp.now(),
        'rating': '5',
        'additionalNotes': 'Great product!',
      };

      final review = Review.fromMap(data);

      expect(review.reviewID, '1');
      expect(review.orderID, '123');
      expect(review.rating, '5');
      expect(review.additionalNotes, 'Great product!');
    });
  });
}
