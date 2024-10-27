import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/product_model.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Add a new product
  Future<String> addProduct(ProductModel product, File thumbnail, List<File> images) async {
    try {
      // Upload thumbnail and set it to product
      String thumbnailUrl = await _uploadImage(thumbnail);
      product.thumbnail = thumbnailUrl;

      // Upload images and add them to product.images
      List<String> imageUrls = [];
      for (var image in images) {
        String imageUrl = await _uploadImage(image);
        imageUrls.add(imageUrl);
      }
      product.images = imageUrls;

      DocumentReference docRef = await _firestore.collection('products').add(product.toMap());
      return docRef.id; // Return the document ID
    } on FirebaseException catch (e) {
      print('Error adding product: $e');
      throw Exception('Failed to add product: ${e.message}');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Failed to add product due to an unexpected error');
    }
  }

  // Update an existing product
  Future<void> updateProduct(String id, ProductModel product, File? newThumbnail, List<File>? newImages) async {
    try {
      if (newThumbnail != null) {
        // Optionally delete old thumbnail if needed
          await deleteImage(product.thumbnail);
        String thumbnailUrl = await _uploadImage(newThumbnail);
        product.thumbnail = thumbnailUrl;
      }

      if (newImages != null && newImages.isNotEmpty) {
        List<String> imageUrls = [];
        for (var image in newImages) {
          String imageUrl = await _uploadImage(image);
          imageUrls.add(imageUrl);
        }
        product.images = imageUrls; // Update images if new ones are provided
      }

      await _firestore.collection('products').doc(id).update(product.toMap());
    } on FirebaseException catch (e) {
      print('Error updating product: $e');
      throw Exception('Failed to update product: ${e.message}');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Failed to update product due to an unexpected error');
    }
  }

  // Delete a product
  Future<void> deleteProduct(String id, String thumbnailUrl, List<String> imageUrls) async {
    try {
      // Delete all associated images
      await deleteImage(thumbnailUrl);
      for (var url in imageUrls) {
        await deleteImage(url);
      }
      await _firestore.collection('products').doc(id).delete();
    } catch (e) {
      print('Error deleting product: $e');
      throw Exception('Failed to delete product');
    }
  }

  // Get all products
  Future<List<ProductModel>> getProducts() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('products').get();
      return snapshot.docs.map((doc) {
        return ProductModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } on FirebaseException catch (e) {
      print('Error getting products: $e');
      throw Exception('Failed to get products: ${e.message}');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Failed to get products due to an unexpected error');
    }
  }

  // Get a product by ID
  Future<ProductModel?> getProductById(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('products').doc(id).get();
      if (doc.exists) {
        return ProductModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      } else {
        return null; // Product not found
      }
    } on FirebaseException catch (e) {
      print('Error getting product by ID: $e');
      throw Exception('Failed to get product: ${e.message}');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Failed to get product due to an unexpected error');
    }
  }

  // Helper method to upload an image to Firebase Storage
  Future<String> _uploadImage(File imagePath) async {
    try {
      final bytes = await imagePath.readAsBytes();
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference storageRef = _storage.ref().child('products/$fileName');

      await storageRef.putData(bytes);
      String downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      print('Error uploading image: $e');
      throw Exception('Failed to upload image');
    }
  }

  // Delete an image from Firebase Storage
  Future<void> deleteImage(String imageUrl) async {
    try {
      await _storage.refFromURL(imageUrl).delete();
    } catch (e) {
      print('Error deleting image: $e');
      rethrow; // Rethrow for upstream handling
    }
  }
}
