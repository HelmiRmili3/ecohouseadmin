import 'dart:io';

import 'package:admin/features/shop/modules/item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ShopRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Fetch products from Firestore
  Stream<List<DocumentSnapshot>> getItems() {
    return _firebaseFirestore
        .collection('items')
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }

  Future<void> addProduct(ItemModule item) async {
    try {
      // Set the document reference (docRef) to be the same as the product ID
      DocumentReference docRef =
          _firebaseFirestore.collection('items').doc(item.id);
      // Set the document data using the set method
      await docRef.set(item.toJson());
    } catch (e) {
      throw Exception('Failed to add product to Firestore: $e');
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

  Future<void> deleteProduct(String itemId) async {
    try {
      CollectionReference collection = _firebaseFirestore.collection('items');
      DocumentReference itemDocument = collection.doc(itemId);
      await itemDocument.delete();
    } catch (e) {
      throw Exception('Failed to remove product from Firestore: $e');
    }
  }
    Future<void> updateProduct(ItemModule item) async {
    try {
      await _firebaseFirestore
          .collection('products')
          .doc(item.id)
          .update(item.toJson());
    } catch (e) {
      throw Exception('Failed to update product in Firestore: $e');
    }
  }
}
