import 'package:admin/features/shop/bloc/shop_bloc.dart';
import 'package:admin/features/shop/modules/item.dart';
import 'package:admin/features/shop/repository/shop_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/list_view.dart';

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  Widget build(BuildContext context) {
    final ShopBloc shopBloc = ShopBloc(repository: ShopRepository());

    return StreamBuilder<List<DocumentSnapshot<Object?>>>(
        stream: shopBloc.shopStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<DocumentSnapshot> itemsSnapshots = snapshot.data!;
            List<ItemModule> items = itemsSnapshots.map((snapshot) {
              return ItemModule.fromSnapshot(snapshot);
            }).toList();
            return SafeArea(
              minimum: const EdgeInsets.all(16.0),
              child: ShopListView(items: items),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        });
  }
}