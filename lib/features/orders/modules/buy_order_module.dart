import 'package:admin/features/shop/modules/item.dart';

class SellOrderModule {
  final List<ItemModule> items;
  final String customerId;
  final DateTime orderDate;

  SellOrderModule({
    required this.items,
    required this.customerId,
    required this.orderDate,
  });

  factory SellOrderModule.fromJson(Map<String, dynamic> json) {
    List<dynamic> itemsJson = json['items'];
    List<ItemModule> items =
        itemsJson.map((itemJson) => ItemModule.fromJson(itemJson)).toList();
    return SellOrderModule(
      items: items,
      customerId: json['customerId'],
      orderDate: DateTime.parse(json['orderDate']),
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> itemsJson =
        items.map((product) => product.toJson()).toList();
    return {
      'products': itemsJson,
      'customerId': customerId,
      'orderDate': orderDate.toIso8601String(),
    };
  }
}
