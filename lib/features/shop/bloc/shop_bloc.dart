import 'dart:async';

import 'package:admin/features/shop/bloc/shop_events.dart';
import 'package:admin/features/shop/bloc/shop_states.dart';
import 'package:admin/features/shop/modules/item.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../repository/shop_repository.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final ShopRepository repository;

  late final StreamSubscription _subscription;

  final _shopController = StreamController<List<DocumentSnapshot>>.broadcast();
  Stream<List<DocumentSnapshot>> get shopStream => _shopController.stream;

  ShopBloc({required this.repository}) : super(ShopInitial()) {
    repository.getItems().listen((items) {
      _shopController.add(items);
    });
    on<AddProduct>(_mapAddProductToState);
    // on<DeleteProduct>(_mapDeleteProductToState);
    // on<UpdateProduct>(_mapUpdateProductToState);
  }

  Future<void> _mapAddProductToState(
      AddProduct event, Emitter<ShopState> emit) async {
    try {
      String imageUrl =
          await repository.uploadImageToFirebaseStorage(event.selectedImage);
      ItemModule item = event.item.copyWith(
        imageUrl: imageUrl,
      );
      repository.addProduct(item);
    } catch (e) {
      throw Exception('Failed to add item to Firestore');
    }
  }

  @override
  Future<void> close() {
    _shopController.close();
    _subscription.cancel();
    return super.close();
  }
}
