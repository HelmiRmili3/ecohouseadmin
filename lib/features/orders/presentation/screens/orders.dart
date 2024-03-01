import 'package:admin/features/orders/presentation/widgets/buy_orders_list.dart';
import 'package:admin/features/orders/presentation/widgets/sell_orders_list.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Orders"),
          automaticallyImplyLeading: false,
          bottom: const TabBar(tabs: [Tab(text: 'Buy'), Tab(text: 'Sell')]),
        ),
        body: const TabBarView(
          children: [BuyOrdersList(), SellOrdersList()],
        ),
      ),
    );
  }
}
