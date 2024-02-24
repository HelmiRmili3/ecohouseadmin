import 'package:admin/features/items/presentation/screens/items.dart';
import 'package:admin/features/orders/presentation/screens/orders.dart';
import 'package:admin/features/profile/presentation/screens/profile.dart';
import 'package:admin/features/shop/presentation/shop.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int myCurrentIndex = 0;
  List<Widget> pages = const [Items(), Orders(), Shop(), Profile()];
  List<String> titles = const ["Items", "Orders", "Shop", "Profile"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(titles[myCurrentIndex]),
        centerTitle: true,
      ),
      body: pages[myCurrentIndex],
      bottomNavigationBar: Container(
        decoration:const BoxDecoration(
        color: Colors.transparent, // Set transparent color
        boxShadow: [], // Remove any shadows
      ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // Set type to fixed
         // backgroundColor: Colors.transparent.withOpacity(0.9), // Set transparent color
        //  elevation: 0, // Set elevation to 0
          onTap: (index) {
            setState(() {
              myCurrentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Items"),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "Orders"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shop_outlined), label: "Shop"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
