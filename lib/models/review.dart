class Review{
  final String reviewID;
  final DateTime createdAt;
  final String rating;
  final String? additionalNotes;

  Review({
    required this.reviewID,
    required this.createdAt,
    required this.rating,
    this.additionalNotes,
  });

  factory Review.fromMap(Map<String, dynamic> data) {
    return Review(
      reviewID: data['reviewID'],
      createdAt: data['createdAt'],
      rating: data['rating'],
      additionalNotes: data['additionalNotes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reviewID': reviewID,
      'createdAt': createdAt,
      'rating': rating,
      'additionalNotes': additionalNotes,
    };
  }
}