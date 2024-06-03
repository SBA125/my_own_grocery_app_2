import 'package:flutter_test/flutter_test.dart';
import 'package:my_own_grocery_app_2/blocs/review/review_event.dart';
import 'package:my_own_grocery_app_2/models/review.dart';

void main() {
  group('AddReview', () {
    test('props are correct', () {
      final review = Review(
        reviewID: '1',
        orderID: 'order_123',
        createdAt: DateTime.now(),
        rating: '5',
        additionalNotes: 'Great product!',
      );
      final addReview = AddReview(review);

      // Verify that props getter returns a list containing the review
      expect(addReview.props, [review]);
    });
  });
}
