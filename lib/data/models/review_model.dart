class ReviewModel {
  final String userId;
  final String comment;
  final double rating;
  final DateTime date;

  ReviewModel({
    required this.userId,
    required this.comment,
    required this.rating,
    required this.date,
  });

  // Convert a Review to a Map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'comment': comment,
      'rating': rating,
      'date': date.toIso8601String(),
    };
  }

  // Create a Review from a Map
  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      userId: map['userId'],
      comment: map['comment'],
      rating: map['rating'],
      date: DateTime.parse(map['date']),
    );
  }
}
