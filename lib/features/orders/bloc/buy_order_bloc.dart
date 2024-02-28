import 'dart:async';
import 'package:admin/features/orders/bloc/buy_order_events.dart';
import 'package:admin/features/orders/bloc/buy_order_states.dart';
import 'package:admin/features/orders/modules/buy_order_module.dart';
import 'package:admin/features/orders/repository/buy_order_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuyOrderBloc extends Bloc<OrderEvents, OrderState> {
  final BuyOrderRespsitory repository;

  late final StreamSubscription _subscription;
  final _ordersController =
      StreamController<List<DocumentSnapshot>>.broadcast();

  Stream<List<DocumentSnapshot>> get ordersStream => _ordersController.stream;

  BuyOrderBloc({required this.repository}) : super(OrdersInitial()) {
    repository.getOrders().listen((orders) {
      _ordersController.add(orders);
    });
    on<AddOrder>(_mapAddOrderToState);

    on<DeleteOrder>(_mapRemoveOrderToState);
  }
  Future<void> _mapAddOrderToState(
      AddOrder event, Emitter<OrderState> emit) async {
    try {
      repository.addOrder(event.order);
    } catch (e) {
      throw Exception('Failed to add product to Firestore');
    }
  }

  Future<void> _mapRemoveOrderToState(
      DeleteOrder event, Emitter<OrderState> emit) async {
    try {
      await repository.deleteOrder(event.id);
    } catch (e) {
      throw Exception('Failed to delete Order to Firestore');
    }
  }

  @override
  Future<void> close() {
    _ordersController.close();
    _subscription.cancel();
    return super.close();
  }
}
