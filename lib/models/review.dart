class Review {
  final String reviewID;
  final String orderID;
  final DateTime createdAt;
  final String rating;
  final String? additionalNotes;

  Review({
    required this.reviewID,
    required this.orderID,
    required this.createdAt,
    required this.rating,
    this.additionalNotes,
  });

  factory Review.fromMap(Map<String, dynamic> data) {
    return Review(
      reviewID: data['reviewID'],
      orderID: data['orderID'],
      createdAt: data['createdAt'].toDate(),
      rating: data['rating'],
      additionalNotes: data['additionalNotes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reviewID': reviewID,
      'orderID': orderID,
      'createdAt': createdAt,
      'rating': rating,
      'additionalNotes': additionalNotes,
    };
  }
}
