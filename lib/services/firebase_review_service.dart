import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/review.dart';

class FirebaseReviewService{
  final FirebaseFirestore _firestore;

  FirebaseReviewService({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;


  Future<void> addReview(Review review) async {
    final doc = _firestore.collection('Reviews').doc('allReviews');
    final snapshot = await doc.get();

    if (snapshot.exists) {
      List<dynamic> reviewsList = snapshot.data()?['reviewsList'] ?? [];
      reviewsList.add(review.toMap());
      await doc.update({'reviewsList': reviewsList});
    } else {
      await doc.set({'reviewsList': [review.toMap()]});
    }
  }
}