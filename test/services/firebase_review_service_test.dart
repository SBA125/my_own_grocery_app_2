import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_own_grocery_app_2/models/review.dart';
import 'package:my_own_grocery_app_2/services/firebase_review_service.dart';

void main() {
  late FirebaseReviewService reviewService;
  late FakeFirebaseFirestore fakeFirestore;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    reviewService = FirebaseReviewService(firestore: fakeFirestore);
  });

  test('adds review to database', () async {
    final review = Review(
      reviewID: 'test-review-id',
      orderID:'test-order-id',
      rating: '5',
      createdAt: DateTime.now(),
    );

    await reviewService.addReview(review);

    final docSnapshot = await fakeFirestore.collection('Reviews').doc('allReviews').get();
    expect(docSnapshot.exists, true);

    final reviewsList = (docSnapshot.data()?['reviewsList'] as List).cast<Map<String, dynamic>>();
    expect(reviewsList.length, 1);
    expect(reviewsList.first['reviewID'], review.reviewID);
  });
}
