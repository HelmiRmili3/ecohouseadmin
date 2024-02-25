import 'dart:async';

import 'package:admin/features/shop/bloc/shop_events.dart';
import 'package:admin/features/shop/bloc/shop_states.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../repository/shop_repository.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final ShopRepository repository;

  late final StreamSubscription _subscription;

  final _shopController = StreamController<List<DocumentSnapshot>>.broadcast();
  Stream<List<DocumentSnapshot>> get shopStream => _shopController.stream;

  ShopBloc({required this.repository}) : super(ShopInitial()) {
    repository.getProducts().listen((products) {
      _shopController.add(products);
    });
  }

  @override
  Future<void> close() {
    _shopController.close();
    _subscription.cancel();
    return super.close();
  }
}
