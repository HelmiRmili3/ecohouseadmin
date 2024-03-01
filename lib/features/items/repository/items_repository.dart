
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Fetch products from Firestore
  Stream<List<DocumentSnapshot>> getProducts() {
    return _firebaseFirestore
        .collection('products')
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }


  //Remove product from Firestore
  // Future<void> deleteProduct(String productId) async {
  //   try {
  //     CollectionReference collection =
  //         _firebaseFirestore.collection('products');
  //     DocumentReference itemDocument = collection.doc(productId);
  //     await itemDocument.delete();
  //   } catch (e) {
  //     throw Exception('Failed to remove product from Firestore: $e');
  //   }
  // }


}
