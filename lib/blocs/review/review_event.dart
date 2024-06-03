import 'package:equatable/equatable.dart';

import '../../models/review.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object> get props => [];
}

class AddReview extends ReviewEvent {
  final Review review;

  const AddReview(this.review);

  @override
  List<Object> get props => [review];
}
