import 'package:admin/features/items/modules/product.dart';
import 'package:equatable/equatable.dart';

abstract class ItemsState extends Equatable {
  const ItemsState();
  @override
  List<Object> get props => [];
  Object? get items => props;
}

class ItemsInitial extends ItemsState {}

class ItemsLoading extends ItemsState {}

class ItemsLoaded extends ItemsState {
  @override
  final List<ProductModule> items;
  const ItemsLoaded(this.items);
}

class ItemsError extends ItemsState {
  final String message;

  const ItemsError(this.message);
}
