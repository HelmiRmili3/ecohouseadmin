import 'package:admin/features/auth/bloc/auth_bloc.dart';
import 'package:admin/features/auth/repository/auth_repository.dart';
import 'package:admin/features/items/bloc/items_bloc.dart';
import 'package:admin/features/items/repository/items_repository.dart';
import 'package:admin/features/orders/bloc/buy_order_bloc.dart';
import 'package:admin/features/orders/repository/buy_order_repository.dart';
import 'package:admin/features/shop/bloc/shop_bloc.dart';
import 'package:admin/features/shop/repository/shop_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> getAppProviders() {
  return [
    BlocProvider<ItemsBloc>(
      create: (context) => ItemsBloc(
        repository: ItemsRepository(),
      ),
    ),
    BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(
        repository: AuthRepository(),
      ),
    ),
    BlocProvider<ShopBloc>(
      create: (context) => ShopBloc(
        repository: ShopRepository(),
      ),
    ),
    BlocProvider<BuyOrderBloc>(
      create: (context) => BuyOrderBloc(
        repository: BuyOrderRespsitory(),
      ),
    ),

    // Add more providers as needed...
  ];
}
