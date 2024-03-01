import 'package:admin/features/items/presentation/screens/items.dart';
import 'package:admin/features/orders/presentation/screens/orders.dart';
import 'package:admin/features/profile/presentation/screens/profile.dart';
import 'package:admin/features/shop/presentation/screens/shop.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int myCurrentIndex = 0;
  List<Widget> pages = const [Items(), Orders(), Shop(), Profile()];
  List<String> titles = const ["Home", "Orders", "Shop", "Profile"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: myCurrentIndex == 1
          ? null
          : AppBar(
              automaticallyImplyLeading: false,
              title: Text(titles[myCurrentIndex]),
              centerTitle: true,
            ),
      body: pages[myCurrentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          boxShadow: [],
        ),
        child: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          currentIndex: myCurrentIndex,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          onTap: (index) {
            setState(() {
              myCurrentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.home,
              ),
              label: titles[0],
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.list,
              ),
              label: titles[1],
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.shop_outlined,
              ),
              label: titles[2],
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.person_outline,
              ),
              label: titles[3],
            ),
          ],
        ),
      ),
    );
  }
}
