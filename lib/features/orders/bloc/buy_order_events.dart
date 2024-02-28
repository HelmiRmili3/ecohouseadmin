import 'package:admin/features/orders/bloc/sell_order_events.dart';
import 'package:admin/features/orders/modules/buy_order_module.dart';
import 'package:equatable/equatable.dart';

abstract class OrderEvents extends Equatable {
  const OrderEvents();
}

class FetchOrder extends OrdersEvents {
  final List<BuyOrderModule> items;
  const FetchOrder({
    required this.items,
  });
  @override
  List<Object?> get props => [items];
}

class DeleteOrder extends OrderEvents {
  final String id;
  const DeleteOrder({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}

class AddOrder extends OrderEvents {
  final BuyOrderModule order;

  const AddOrder({required this.order});

  @override
  List<Object?> get props => [order];
}
