import 'package:admin/features/items/bloc/items_bloc.dart';
import 'package:admin/features/items/modules/product.dart';
import 'package:admin/features/items/presentation/widgets/add_item_card.dart';
import 'package:admin/features/items/repository/items_repository.dart';
import 'package:admin/shared/repository/shared_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/item_card.dart';

class Items extends StatefulWidget {
  const Items({super.key});

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  @override
  Widget build(BuildContext context) {
    final ItemsBloc itemsBloc = ItemsBloc(
      repository: ItemsRepository(),
      sharedRepository: SharedRepository(),
    );
    return StreamBuilder<List<DocumentSnapshot<Object?>>>(
      stream: itemsBloc.productsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          List<DocumentSnapshot<Object?>> productsSnapshots = snapshot.data!;
          List<ProductModule> products = productsSnapshots.map((snapshot) {
            return ProductModule.fromSnapshot(snapshot);
          }).toList();
          return SafeArea(
            minimum: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Items',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    itemCount: products.length + 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == products.length) {
                        return const AddItemCard();
                      } else {
                        return ProductCard(product: products[index]);
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
