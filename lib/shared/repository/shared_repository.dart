import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SharedRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> delete(String docId, String collectionName) async {
    try {
      CollectionReference collection =
          _firebaseFirestore.collection(collectionName);
      DocumentReference document = collection.doc(docId);
      await document.delete();
    } catch (e) {
      throw Exception('Failed to remove doc from Firestore: $e');
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

  Future<void> add(Map<String, dynamic> item, String collectionName) async {
    try {
      // Set the document reference (docRef) to be the same as the product ID
      DocumentReference docRef =
          _firebaseFirestore.collection(collectionName).doc(item['id']);
      // Set the document data using the set method
      await docRef.set(item);
    } catch (e) {
      throw Exception('Failed to add product to Firestore: $e');
    }
  }

  Future<void> update(Map<String, dynamic> item, String collectionName) async {
    try {
      await _firebaseFirestore
          .collection(collectionName)
          .doc(item['id'])
          .update(item);
    } catch (e) {
      throw Exception('Failed to update product in Firestore: $e');
    }
  }
}
