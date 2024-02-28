import 'package:admin/features/orders/modules/buy_order_module.dart';
import 'package:equatable/equatable.dart';

abstract class OrderState extends Equatable {
  const OrderState();
  @override
  List<Object> get props => [];
  Object? get orders => props;
}

class OrdersInitial extends OrderState {}

class OrdersLoading extends OrderState {}

class OrdersLoaded extends OrderState {
  @override
  final List<BuyOrderModule> orders;

  const OrdersLoaded({required this.orders});
}

class OrdersError extends OrderState {
  final String message;

  const OrdersError(this.message);
}
