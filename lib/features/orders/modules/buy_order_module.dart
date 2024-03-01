import 'package:admin/features/items/modules/product.dart';
import 'package:uuid/uuid.dart';

import '../../../core/enums.dart';

class BuyOrderModule {
  final String id;
  final List<ProductModule> products;
  final String customerId;
  final DateTime orderDate;
  final int totalPrice;
  final int totalWeight;
  final Status status;

  BuyOrderModule({
    required this.id,
    required this.products,
    required this.customerId,
    required this.orderDate,
    required this.totalPrice,
    required this.totalWeight,
    required this.status,
  });

  factory BuyOrderModule.create({
    required List<ProductModule> products,
    required String customerId,
    required int totalPrice,
    required int totalWeight,
    required Status status,
  }) {
    final String id = const Uuid().v1();
    final DateTime orderDate = DateTime.now();
    return BuyOrderModule(
      id: id,
      products: products,
      customerId: customerId,
      orderDate: orderDate,
      totalPrice: totalPrice,
      totalWeight: totalWeight,
      status: status,
    );
  }

  factory BuyOrderModule.fromJson(Map<String, dynamic> json) {
    List<dynamic> productsJson = json['products'];
    List<ProductModule> products = productsJson
        .map((productJson) => ProductModule.fromSnapshot(productJson))
        .toList();
    return BuyOrderModule(
      id: json['id'],
      products: products,
      customerId: json['customerId'],
      orderDate: DateTime.parse(json['orderDate']),
      totalPrice: json['totalPrice'],
      totalWeight: json['totalWeight'],
      status: _getStatusFromString(json['status']),
    );
  }

  factory BuyOrderModule.fromSnapshot(Map<String, dynamic> snapshot) {
    List<dynamic> productsJson = snapshot['products'];
    List<ProductModule> products = productsJson
        .map((productJson) => ProductModule.fromJson(productJson))
        .toList();

    String id = snapshot['id'];
    String customerId = snapshot['customerId'];
    DateTime orderDate = DateTime.parse(snapshot['orderDate']);
    int totalPrice = snapshot['totalPrice'];
    int totalWeight = snapshot['totalWeight'];
    Status status = _getStatusFromString(snapshot['status']);

    return BuyOrderModule(
      id: id,
      products: products,
      customerId: customerId,
      orderDate: orderDate,
      totalPrice: totalPrice,
      totalWeight: totalWeight,
      status: status,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> productsJson =
        products.map((product) => product.toJson()).toList();
    return {
      'id': id,
      'products': productsJson,
      'customerId': customerId,
      'orderDate': orderDate.toIso8601String(),
      'totalPrice': totalPrice,
      'totalWeight': totalWeight,
      'status': status.toString().split('.').last, // Convert enum to string
    };
  }

  static Status _getStatusFromString(String statusString) {
    return Status.values.firstWhere(
        (status) =>
            status.toString().split('.').last == statusString.toLowerCase(),
        orElse: () => Status.waiting); // Default to waiting if not found
  }
}
