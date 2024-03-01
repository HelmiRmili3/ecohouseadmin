import 'package:admin/shared/repository/shared_repository.dart';
import 'package:flutter/material.dart';

import '../../../../core/routes.dart';
import '../../bloc/buy_order_bloc.dart';
import '../../modules/buy_order_module.dart';
import '../../repository/buy_order_repository.dart';
import 'order_card.dart';

class BuyOrdersList extends StatelessWidget {
  const BuyOrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    final BuyOrderBloc buyOrderBloc = BuyOrderBloc(
      repository: BuyOrderRespsitory(),
      sharedRepository: SharedRepository(),
    );
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
            child: SizedBox(
              height: 500,
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
            ),
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
