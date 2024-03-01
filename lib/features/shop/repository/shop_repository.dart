import 'package:cloud_firestore/cloud_firestore.dart';

class ShopRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Fetch products from Firestore
  Stream<List<DocumentSnapshot>> getItems() {
    return _firebaseFirestore
        .collection('items')
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }
}
