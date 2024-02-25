import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin/features/auth/presentation/widgets/custom_form_field.dart';
import 'package:admin/features/items/bloc/items_bloc.dart';
import 'package:admin/features/items/modules/product.dart';
import 'package:admin/features/items/repository/items_repository.dart';
import '../../../../core/constants.dart';
import '../../../../utils/app_utils.dart';
import '../../bloc/items_events.dart';
import '../widgets/pick_image_widget.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  File? _selectedImage;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController();

  Future<void> addItem() async {
    try {
      ProductModule productModule = ProductModule.create(
        name: _nameController.text,
        pointsPerKg: int.tryParse(_pointsController.text) ?? 0,
        weight: 0,
      );
      context
          .read<ItemsBloc>()
          .add(AddItem(product: productModule, selectedImage: _selectedImage));
      Navigator.of(context).pop();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _pointsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Item"),
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
                    labelText: "Points Per Kg",
                    controller: _pointsController,
                  ),
                  const SizedBox(height: 20),
                  BlocProvider(
                    create: (context) =>
                        ItemsBloc(repository: ItemsRepository()),
                    child: ElevatedButton(
                      onPressed: addItem,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent[100],
                        padding: const EdgeInsets.all(18.0),
                      ),
                      child: const Text(
                        "Add",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
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
