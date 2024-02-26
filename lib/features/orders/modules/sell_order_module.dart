import 'package:admin/features/items/modules/product.dart';

class SellOrderModule {
  final List<ProductModule> products;
  final String customerId;
  final DateTime orderDate;
  
  SellOrderModule({
    required this.products,
    required this.customerId,
    required this.orderDate,
  });

  factory SellOrderModule.fromJson(Map<String, dynamic> json) {
    List<dynamic> productsJson = json['products'];
    List<ProductModule> products = productsJson.map((productJson) => ProductModule.fromJson(productJson)).toList();
    return SellOrderModule(
      products: products,
      customerId: json['customerId'],
      orderDate: DateTime.parse(json['orderDate']),
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> productsJson = products.map((product) => product.toJson()).toList();
    return {
      'products': productsJson,
      'customerId': customerId,
      'orderDate': orderDate.toIso8601String(),
    };
  }
}