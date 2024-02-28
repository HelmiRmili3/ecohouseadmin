import 'package:admin/features/orders/modules/buy_order_module.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuyOrderRespsitory {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<DocumentSnapshot>> getOrders() {
    return _firebaseFirestore
        .collection('orders')
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }

    //Remove product from Firestore
  Future<void> deleteOrder(String orderId) async {
    try {
      CollectionReference collection =
          _firebaseFirestore.collection('orders');
      DocumentReference itemDocument = collection.doc(orderId);
      await itemDocument.delete();
    } catch (e) {
      throw Exception('Failed to remove orders from Firestore: $e');
    }
  }

  // Add product to Firestore
  Future<void> addOrder(BuyOrderModule order) async {
    try {
      // Set the document reference (docRef) to be the same as the product ID
      DocumentReference docRef =
          _firebaseFirestore.collection('orders').doc(order.id);
      // Set the document data using the set method
      await docRef.set(order.toJson());
    } catch (e) {
      throw Exception('Failed to add product to Firestore: $e');
    }
  }

}
