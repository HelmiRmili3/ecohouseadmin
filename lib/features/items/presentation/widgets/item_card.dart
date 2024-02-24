import 'package:admin/features/items/bloc/items_bloc.dart';
import 'package:admin/features/items/presentation/screens/update_item_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/items_events.dart';
import '../../modules/product.dart';

class ProductCard extends StatefulWidget {
  final ProductModule product;
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16.0),
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.product.image),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      context.read<ItemsBloc>().add(RemoveItem(
                            id: widget.product.id,
                            imageUrl: widget.product.image,
                          ));
                    },
                    child: const Text(
                      "Delete",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UpdateItemPage(
                            id: widget.product.id,
                            image: widget.product.image,
                            name: widget.product.name,
                            pointsPerKg: widget.product.pointsPerKg,
                          ),
                        ),
                      );
                    },
                    child: const Text("Update"),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 8.0,
            right: 8.0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                '${widget.product.pointsPerKg.toString()} P',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
