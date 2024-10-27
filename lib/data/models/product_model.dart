import 'review_model.dart';

class ProductModel {
  final String id;
  final String title;
  final String description;
  final String categoryID;
  final List<ReviewModel> reviews;
  final double price;
  final int quantity;
  String thumbnail; // Renamed from largeImage to thumbnail
  List<String> images; // Renamed from smallImages to images
  final DateTime createdAt;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryID,
    required this.reviews,
    required this.price,
    required this.quantity,
    required this.thumbnail, // Updated field
    required this.images, // Updated field
    required this.createdAt,
  });

  // Convert a Product to a Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'categoryID': categoryID,
      'reviews': reviews.map((review) => review.toMap()).toList(),
      'price': price,
      'quantity': quantity,
      'thumbnail': thumbnail, // Updated field
      'images': images, // Updated field
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create a Product from a Map
  factory ProductModel.fromMap(Map<String, dynamic> map, String id) {
    return ProductModel(
      id: id,
      title: map['title'],
      description: map['description'],
      categoryID: map['categoryID'],
      reviews: List<ReviewModel>.from(
          map['reviews']?.map((review) => ReviewModel.fromMap(review)) ?? []),
      price: map['price'],
      quantity: map['quantity'],
      thumbnail: map['thumbnail'], // Updated field
      images: List<String>.from(map['images']), // Updated field
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
