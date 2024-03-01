import 'package:admin/features/items/modules/product.dart';
import 'package:uuid/uuid.dart';

class BuyOrderModule {
  final String id; // Added id field
  final List<ProductModule> products;
  final String customerId;
  final DateTime orderDate;

  BuyOrderModule({
    required this.id,
    required this.products,
    required this.customerId,
    required this.orderDate,
  });

  factory BuyOrderModule.create({
    required List<ProductModule> products,
    required String customerId,
  }) {
    final String id = const Uuid().v1();
    final DateTime orderDate = DateTime.now();
    return BuyOrderModule(
      id: id,
      products: products,
      customerId: customerId,
      orderDate: orderDate,
    );
  }

  factory BuyOrderModule.fromJson(Map<String, dynamic> json) {
    List<dynamic> productsJson = json['products'];
    List<ProductModule> products = productsJson
        .map((productJson) => ProductModule.fromSnapshot(productJson))
        .toList();
    return BuyOrderModule(
      id: json['id'], // Added id field initialization
      products: products,
      customerId: json['customerId'],
      orderDate: DateTime.parse(json['orderDate']),
    );
  }


factory BuyOrderModule.fromSnapshot(Map<String, dynamic> snapshot) {
  // Extract the list of products from the snapshot
  List<dynamic> productsJson = snapshot['products'];

  // Convert each product JSON to a ProductModule object
  List<ProductModule> products = productsJson
    .map((productJson) => ProductModule.fromJson(productJson))
    .toList();

  // Extract other fields from the snapshot
  String id = snapshot['id'];
  String customerId = snapshot['customerId'];
  DateTime orderDate = DateTime.parse(snapshot['orderDate']);

  // Create and return the BuyOrderModule object
  return BuyOrderModule(
    id: id,
    products: products,
    customerId: customerId,
    orderDate: orderDate,
  );
}



  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> productsJson =
        products.map((product) => product.toJson()).toList();
    return {
      'id': id, // Added id field serialization
      'products': productsJson,
      'customerId': customerId,
      'orderDate': orderDate.toIso8601String(),
    };
  }
}
