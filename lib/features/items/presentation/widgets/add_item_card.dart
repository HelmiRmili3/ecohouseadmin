import 'package:flutter/material.dart';

import '../../../../core/routes.dart';

class AddItemCard extends StatelessWidget {
  const AddItemCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.addItemPage);
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: const Center(
            child: Icon(
          Icons.add,
          size: 40,
          color: Colors.blueAccent,
        )),
      ),
    );
  }
}
