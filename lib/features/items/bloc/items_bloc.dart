import 'dart:async';

import 'package:admin/features/items/bloc/items_events.dart';
import 'package:admin/features/items/bloc/items_states.dart';
import 'package:admin/features/items/modules/product.dart';
import 'package:admin/features/items/repository/items_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final ItemsRepository repository;

  late final StreamSubscription _subscription;
  final _productsController =
      StreamController<List<DocumentSnapshot>>.broadcast();

  Stream<List<DocumentSnapshot>> get productsStream =>
      _productsController.stream;

  ItemsBloc({required this.repository}) : super(ItemsInitial()) {
    repository.getProducts().listen((products) {
      _productsController.add(products);
    });
    on<AddItem>(_mapAddItemToState);
    on<RemoveItem>(_mapRemoveItemToState);
    on<UpdateItem>(_mapUpdateItemToState);
  }

  Future<void> _mapAddItemToState(
      AddItem event, Emitter<ItemsState> emit) async {
    try {
      String imageUrl =
          await repository.uploadImageToFirebaseStorage(event.selectedImage);
      ProductModule productModule = ProductModule(
        id: event.product.id,
        name: event.product.name,
        pointsPerKg: event.product.pointsPerKg,
        weight: event.product.weight,
        image: imageUrl,
      );
      repository.addProduct(productModule);
    } catch (e) {
      throw Exception('Failed to add product to Firestore');
    }
  }

  Future<void> _mapRemoveItemToState(
      RemoveItem event, Emitter<ItemsState> emit) async {
    try {
      await repository.deleteImageFromFirebaseStorage(event.imageUrl);
      await repository.deleteProduct(event.id);
    } catch (e) {
      throw Exception('Failed to delete product to Firestore');
    }
  }

  Future<void> _mapUpdateItemToState(
      UpdateItem event, Emitter<ItemsState> emit) async {
    try {
      await repository.updateProduct(event.product);
    } catch (e) {
      throw Exception('Failed to update product to Firestore');
    }
  }

  @override
  Future<void> close() {
    _productsController.close();
    _subscription.cancel();
    return super.close();
  }
}
