import 'dart:io';

import 'package:admin/features/items/modules/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class ItemsRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  //  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Fetch products from Firestore
  Stream<List<DocumentSnapshot>> getProducts() {
    return _firebaseFirestore
        .collection('products')
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }

  // Add product to Firestore
  Future<void> addProduct(ProductModule product) async {
    try {
      // Set the document reference (docRef) to be the same as the product ID
      DocumentReference docRef =
          _firebaseFirestore.collection('products').doc(product.id);

      // Set the document data using the set method
      await docRef.set(product.toJson());
    } catch (e) {
      throw Exception('Failed to add product to Firestore: $e');
    }
  }

  //Remove product from Firestore
  Future<void> deleteProduct(String productId) async {
    try {
      CollectionReference collection =
          _firebaseFirestore.collection('products');
      DocumentReference itemDocument = collection.doc(productId);
      await itemDocument.delete();

    } catch (e) {
      throw Exception('Failed to remove product from Firestore: $e');
    }
  }

  // Update product in Firestore
  Future<void> updateProduct(ProductModule product) async {
    try {
      await _firebaseFirestore
          .collection('products')
          .doc(product.id)
          .update(product.toJson());
    } catch (e) {
      throw Exception('Failed to update product in Firestore: $e');
    }
  }

  Future<void> deleteImageFromFirebaseStorage(String imageUrl) async {
    try {
      Reference imageRef = FirebaseStorage.instance.refFromURL(imageUrl);
      await imageRef.delete();
    } catch (e) {
      throw Exception('Error deleting image: $e');
    }
  }

  Future<String> uploadImageToFirebaseStorage(File? imageFile) async {
    if (imageFile == null) return '';

    final storage = FirebaseStorage.instance;
    final Reference storageReference =
        storage.ref().child('images/${DateTime.now().toString()}');
    final UploadTask uploadTask = storageReference.putFile(
      File(imageFile.path),
    );
    await uploadTask.whenComplete(() => null);
    final String imageUrl = await storageReference.getDownloadURL();

    return imageUrl;
  }
}
