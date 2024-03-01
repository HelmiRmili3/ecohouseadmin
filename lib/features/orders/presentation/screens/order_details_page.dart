import 'package:admin/features/orders/presentation/widgets/products_list.dart';
import 'package:flutter/material.dart';

import '../../../items/modules/product.dart';

class OrderDetails extends StatefulWidget {
  final List<ProductModule> products;
  const OrderDetails({super.key, required this.products});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Order Details"),
      ),
      body: ProductsList(products: widget.products),
    );
  }
}
