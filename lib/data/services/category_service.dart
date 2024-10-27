// import 'dart:io';
import 'package:image_picker/image_picker.dart';
// import 'package:universal_io/io.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/category_model.dart';

class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Add a new category
  Future<String> addCategory(CategoryModel category, XFile imagePath) async {
    try {
      String imageUrl = await _uploadImage(imagePath);
      category.image = imageUrl;

      DocumentReference docRef = await _firestore.collection('categories').add(category.toMap());
      return docRef.id; // Return the document ID
    } on FirebaseException catch (e) {
      print('Error adding category: $e');
      throw Exception('Failed to add category: ${e.message}');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Failed to add category due to an unexpected error');
    }
  }

  // Update an existing category
  Future<void> updateCategory(String id, CategoryModel category, XFile? newImageFile) async {
    try {
      // print(' Old image: ${category.image!}');
      // print(' New image: ${newImageFile?.path}');
      if(newImageFile !=null){
        deleteImage(category.image!);
        String imageUrl =await _uploadImage(newImageFile);
        category.image=imageUrl;
      }
      await _firestore.collection('categories').doc(id).update(category.toMap());
    } on FirebaseException catch (e) {
      print('Error updating category: $e');
      throw Exception('Failed to update category: ${e.message}');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Failed to update category due to an unexpected error');
    }
  }

  // Get all categories 
  Future<List<CategoryModel>> getCategories() async {
    QuerySnapshot snapshot = await _firestore.collection('categories').get();
    return snapshot.docs.map((doc) {
      return CategoryModel.fromMap(doc.data() as Map<String, dynamic>,doc.id);
    }).toList();
  }
  // Get a category by its ID
  Future<CategoryModel> getCategoryById(String id) async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection('categories').doc(id).get();
      if (!snapshot.exists) {
        throw Exception('Category with ID $id does not exist');
      }
      print("Category retrieved successfully: ${snapshot.data()}");
      return CategoryModel.fromMap(snapshot.data() as Map<String, dynamic>, snapshot.id);
    } on FirebaseException catch (e) {
      print('Error getting category by ID: $e');
      throw Exception('Failed to get category by ID: ${e.message}');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Failed to get category by ID due to an unexpected error');
    }
  }

  // Delete a category
  Future<void> deleteCategory(String id,String oldImage) async {
    deleteImage(oldImage);
    await _firestore.collection('categories').doc(id).delete();
  }

  // Helper method to upload an image to Firebase Storage
  Future<String> _uploadImage(XFile imagePath) async {
    try {
      final bytes = await imagePath.readAsBytes();
      // File imageFile = File(imagePath);
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference storageRef = _storage.ref().child('categories/$fileName');

      await storageRef.putData(bytes);
      String downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      print('Error uploading image: $e');
      throw Exception('Failed to upload image');
    }
  }
  Future<void> deleteImage(String imageUrl) async {
    try {
      await _storage.refFromURL(imageUrl).delete();
    } catch (e) {
      print('Error deleting image: $e');
      rethrow; // Rethrow for upstream handling
    }
  }
}
