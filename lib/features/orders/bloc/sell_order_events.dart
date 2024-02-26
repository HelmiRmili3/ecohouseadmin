import 'package:admin/features/orders/modules/sell_order_module.dart';
import 'package:equatable/equatable.dart';

abstract class OrdersEvents extends Equatable {
  const OrdersEvents();
}

class FetchOrders extends OrdersEvents {
  late final SellOrderModule order;

  @override
  List<Object?> get props => [order];
}

