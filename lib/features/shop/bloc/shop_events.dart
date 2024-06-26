import 'dart:io';

import 'package:admin/features/shop/modules/item.dart';
import 'package:equatable/equatable.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();
}

class FetchProducts extends ShopEvent {
  late final List<ItemModule> items;
  @override
  List<Object?> get props => [items];
}

class AddProduct extends ShopEvent {
  final ItemModule item;
  final File? selectedImage;
  const AddProduct({required this.item, this.selectedImage});
  @override
  List<Object?> get props => [item, selectedImage];
}

class DeleteProduct extends ShopEvent {
  final ItemModule item;
  const DeleteProduct({required this.item});
  @override
  List<Object?> get props => [item];
}

class UpdateProduct extends ShopEvent {
  late final ItemModule item;
  late final File? image;
  @override
  List<Object?> get props => [item, image];
}
