import 'dart:io';

import 'package:admin/features/shop/bloc/shop_events.dart';
import 'package:admin/features/shop/modules/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants.dart';
import '../../../../utils/app_utils.dart';
import '../../../auth/presentation/widgets/custom_form_field.dart';
import '../../../items/presentation/widgets/pick_image_widget.dart';
import '../../bloc/shop_bloc.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  File? _selectedImage;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController();
  final TextEditingController _discriptionController = TextEditingController();

  Future<void> addProduct() async {
    try {
      ItemModule item = ItemModule.create(
        name: _nameController.text,
        points: int.tryParse(_pointsController.text) ?? 0,
        description: _discriptionController.text,
      );
      context.read<ShopBloc>().add(AddProduct(
            item: item,
            selectedImage: _selectedImage,
          ));
      Navigator.of(context).pop();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _pointsController.dispose();
    _discriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
        centerTitle: true,
      ),
      body: Center(
        child: SafeArea(
          minimum: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () async {
                      _selectedImage = await pickImage();
                      setState(() {});
                    },
                    child: PickImageWidget(
                      placeholderImage: Constants.placeholderLink,
                      image: _selectedImage,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomFormField(
                    keyboardType: TextInputType.text,
                    labelText: "Name",
                    controller: _nameController,
                  ),
                  const SizedBox(height: 20),
                  CustomFormField(
                    keyboardType: TextInputType.number,
                    labelText: "Points",
                    controller: _pointsController,
                  ),
                  const SizedBox(height: 20),
                  CustomFormField(
                    keyboardType: TextInputType.text,
                    labelText: "Description",
                    controller: _discriptionController,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: addProduct,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent[100],
                      padding: const EdgeInsets.all(18.0),
                    ),
                    child: const Text(
                      "Add",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
