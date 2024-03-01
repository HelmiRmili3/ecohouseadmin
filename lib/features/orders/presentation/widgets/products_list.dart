import 'package:flutter/material.dart';

import '../../../items/modules/product.dart';

class ProductsList extends StatelessWidget {
  final List<ProductModule> products;
  const ProductsList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: products.map((product) {
        return Text(
          '- ${product.name}',
          style: const TextStyle(fontSize: 14),
        );
      }).toList(),
    );
  }
}
