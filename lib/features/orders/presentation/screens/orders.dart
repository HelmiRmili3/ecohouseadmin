import 'package:admin/core/routes.dart';
import 'package:admin/features/orders/bloc/buy_order_bloc.dart';
import 'package:admin/features/orders/modules/buy_order_module.dart';
import 'package:admin/features/orders/presentation/widgets/order_card.dart';
import 'package:flutter/material.dart';

import '../../repository/buy_order_repository.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    final BuyOrderBloc buyOrderBloc =
        BuyOrderBloc(repository: BuyOrderRespsitory());

    return StreamBuilder<List<BuyOrderModule>>(
      stream: buyOrderBloc.ordersStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          List<BuyOrderModule> orders = snapshot.data!;
          return SafeArea(
            minimum: const EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.orderDetailsPage,
                        arguments: orders[index].products);
                  },
                  child: OrderCard(order: orders[index]),
                );
              },
            ),
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
