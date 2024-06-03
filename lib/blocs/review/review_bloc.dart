import 'package:bloc/bloc.dart';
import 'package:my_own_grocery_app_2/blocs/review/review_event.dart';
import 'package:my_own_grocery_app_2/blocs/review/review_state.dart';

import '../../repositories/review_repository.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRepository reviewRepository;

  ReviewBloc({required this.reviewRepository}) : super(ReviewInitial()) {
    on<AddReview>(_onAddReview);
  }

  Future<void> _onAddReview(AddReview event, Emitter<ReviewState> emit) async {
    emit(ReviewLoading());
    try {
      await reviewRepository.addReview(event.review);
      emit(ReviewSuccess());
    } catch (e) {
      emit(ReviewError(e.toString()));
    }
  }
}
