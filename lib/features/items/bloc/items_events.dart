import 'dart:io';

import 'package:admin/features/items/modules/product.dart';
import 'package:equatable/equatable.dart';

abstract class ItemsEvent extends Equatable {
  const ItemsEvent();
}

class FetchItems extends ItemsEvent {
  late final List<ProductModule> items;
  @override
  List<Object?> get props => [items];
}

class AddItem extends ItemsEvent {
  final ProductModule product;
  final File? selectedImage;

  const AddItem({required this.selectedImage, required this.product});
  @override
  List<Object?> get props => [product];
}

class RemoveItem extends ItemsEvent {
  final String id;
  final String imageUrl;
  const RemoveItem({required this.imageUrl, required this.id});
  @override
  List<Object?> get props => [id];
}

class UpdateItem extends ItemsEvent {
  final ProductModule product;

  const UpdateItem({required this.product});

  @override
  List<Object?> get props => [product];
}
