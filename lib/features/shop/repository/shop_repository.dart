import 'package:cloud_firestore/cloud_firestore.dart';

class ShopRepository {
   final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Fetch products from Firestore
  Stream<List<DocumentSnapshot>> getProducts() {
    return _firebaseFirestore
        .collection('products')
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }
}
