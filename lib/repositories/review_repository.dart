import 'package:my_own_grocery_app_2/models/review.dart';

import '../services/firebase_review_service.dart';

class ReviewRepository{
  final FirebaseReviewService firebaseReviewService;

  ReviewRepository({required this.firebaseReviewService});

  Future<void> addReview(Review review) async{
    await firebaseReviewService.addReview(review);
  }
}