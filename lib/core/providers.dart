import 'package:admin/features/auth/bloc/auth_bloc.dart';
import 'package:admin/features/auth/repository/auth_repository.dart';
import 'package:admin/features/items/bloc/items_bloc.dart';
import 'package:admin/features/items/repository/items_repository.dart';
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

    // Add more providers as needed...
  ];
}
