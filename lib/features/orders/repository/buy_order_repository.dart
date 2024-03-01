import 'package:admin/features/orders/modules/buy_order_module.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuyOrderRespsitory {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<BuyOrderModule>> getOrders() {
    return _firebaseFirestore
        .collection('orders')
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      return snapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        return BuyOrderModule.fromSnapshot(doc.data());
      }).toList();
    });
  }
}
