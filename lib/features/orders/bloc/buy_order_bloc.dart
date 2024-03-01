import 'dart:async';
import 'package:admin/features/orders/bloc/buy_order_events.dart';
import 'package:admin/features/orders/bloc/buy_order_states.dart';
import 'package:admin/features/orders/modules/buy_order_module.dart';
import 'package:admin/features/orders/repository/buy_order_repository.dart';
import 'package:admin/shared/repository/shared_repository.dart';
import 'package:bloc/bloc.dart';

class BuyOrderBloc extends Bloc<OrderEvents, OrderState> {
  final BuyOrderRespsitory repository;
  final SharedRepository sharedRepository;
  String collectionName = 'orders';

  late final StreamSubscription _subscription;
  final _ordersController = StreamController<List<BuyOrderModule>>.broadcast();

  Stream<List<BuyOrderModule>> get ordersStream => _ordersController.stream;

  BuyOrderBloc({
    required this.repository,
    required this.sharedRepository,
  }) : super(OrdersInitial()) {
    repository.getOrders().listen((orders) {
      _ordersController.add(orders);
    });
    on<AddOrder>(_mapAddOrderToState);
    on<DeleteOrder>(_mapRemoveOrderToState);
  }
  Future<void> _mapAddOrderToState(
      AddOrder event, Emitter<OrderState> emit) async {
    try {
      sharedRepository.add(event.order.toJson(), collectionName);
    } catch (e) {
      throw Exception('Failed to add product to Firestore');
    }
  }

  Future<void> _mapRemoveOrderToState(
      DeleteOrder event, Emitter<OrderState> emit) async {
    try {
      await sharedRepository.delete(
        event.id,
        collectionName,
      );
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
