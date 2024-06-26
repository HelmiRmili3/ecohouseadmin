import 'package:admin/features/auth/presentation/screens/login_screen.dart';
import 'package:admin/features/home/presentation/screens/home.dart';
import 'package:admin/features/items/presentation/screens/add_item_page.dart';
import 'package:admin/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:admin/features/orders/presentation/screens/order_details_page.dart';
import 'package:admin/features/shop/presentation/screens/add_product_page.dart';
import 'package:flutter/material.dart';

import '../features/items/modules/product.dart';

Map<String, WidgetBuilder> routes = {
  Routes.onboarding: (context) => const OnboardingScreen(),
  Routes.login: (context) => const LoginScreen(),
  Routes.home: (context) => const HomeScreen(),
  Routes.addItemPage: (context) => const AddItemPage(),
  Routes.addProductPage: (context) => const AddProductPage(),
  Routes.orderDetailsPage: (context) => OrderDetails(
      products:
          ModalRoute.of(context)?.settings.arguments as List<ProductModule>)
};

class Routes {
  static const String onboarding = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String addItemPage = '/addItemPage';
  static const String addProductPage = '/addProductPage';
  static const String orderDetailsPage = '/orderDetailsPage';
}
