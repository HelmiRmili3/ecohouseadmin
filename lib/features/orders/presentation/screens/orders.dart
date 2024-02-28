import 'package:admin/features/orders/bloc/buy_order_bloc.dart';
import 'package:admin/features/orders/bloc/buy_order_events.dart';
import 'package:admin/features/orders/modules/buy_order_module.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/buy_order_repository.dart';

class Orders extends StatefulWidget {
  const Orders({super.key}); // Fix constructor

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    final BuyOrderBloc buyOrderBloc = BuyOrderBloc(
        repository: BuyOrderRespsitory()); // Correct typo in repository name

    return Column(
      children: [
        ElevatedButton(
          onPressed: () => {
            BlocProvider.of<BuyOrderBloc>(context).add(AddOrder(
              order: BuyOrderModule.create(
                  products: [], customerId: '1bBf3mnGzJN3LQiPhdwHHNRy3TX2'),
            ))
          },
          child: const Text("add"),
        ),
        Container(
          height: 300,
          child: StreamBuilder<List<DocumentSnapshot<Object?>>>(
            stream: buyOrderBloc.ordersStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                List<DocumentSnapshot> ordersSnapshots =
                    snapshot.data!; // Correct the type and access the docs
                List<BuyOrderModule> orders = ordersSnapshots.map((snapshot) {
                  return BuyOrderModule.fromSnapshot(snapshot);
                }).toList();
                return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    // Provide a builder function
                    return ListTile(
                      title: Text('Order ${index + 1}'),
                    );
                  },
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
        ),
      ],
    );
  }
}
