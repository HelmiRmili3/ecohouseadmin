import 'package:admin/features/shop/modules/item.dart';
import 'package:equatable/equatable.dart';

abstract class ShopState extends Equatable {
  const ShopState();
  @override
  List<Object> get props => [];
  Object? get items => props;
}

class ShopInitial extends ShopState {}

class ShopLoading extends ShopState {}

class ShopLoaded extends ShopState {
  @override
  final List<ItemModule> items;
  const ShopLoaded(this.items);
}

class ShopError extends ShopState {
  final String message;

  const ShopError(this.message);
}
