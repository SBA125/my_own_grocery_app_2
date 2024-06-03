import 'package:flutter_test/flutter_test.dart';
import 'package:my_own_grocery_app_2/blocs/review/review_state.dart';

void main() {
  group('ReviewError', () {
    test('props are correct', () {
      const errorMessage = 'Failed to add review';
      const reviewError = ReviewError(errorMessage);

      // Verify that props getter returns a list containing the error message
      expect(reviewError.props, [errorMessage]);
    });
  });
}
