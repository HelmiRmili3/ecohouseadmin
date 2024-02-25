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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(titles[myCurrentIndex]),
        centerTitle: true,
      ),
      body: pages[myCurrentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
          boxShadow: [],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          onTap: (index) {
            setState(() {
              myCurrentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: myCurrentIndex == 0 ? Colors.black : Colors.grey,
              ),
              label: titles[myCurrentIndex],
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                color: myCurrentIndex == 1 ? Colors.black : Colors.grey,
              ),
              label: titles[myCurrentIndex],
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shop_outlined,
                color: myCurrentIndex == 2 ? Colors.black : Colors.grey,
              ),
              label: titles[myCurrentIndex],
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                color: myCurrentIndex == 3 ? Colors.black : Colors.grey,
              ),
              label: titles[myCurrentIndex],
            ),
          ],
        ),
      ),
    );
  }
}
