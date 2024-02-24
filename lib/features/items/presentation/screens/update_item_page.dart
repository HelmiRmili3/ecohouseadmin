import 'dart:io';

import 'package:admin/features/auth/presentation/widgets/custom_form_field.dart';
import 'package:admin/features/items/bloc/items_bloc.dart';
import 'package:admin/features/items/modules/product.dart';
import 'package:admin/features/items/repository/items_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/app_utils.dart';
import '../../bloc/items_events.dart';
import '../widgets/pick_image_widget.dart';

class UpdateItemPage extends StatefulWidget {
  const UpdateItemPage({super.key});

  @override
  State<UpdateItemPage> createState() => _UpdateItemPageState();
}

class _UpdateItemPageState extends State<UpdateItemPage> {
  File? _selectedImage;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController();
  
  Future<void> addItem() async {
    try {
      ProductModule productModule = ProductModule.create(
        name: _nameController.text,
        pointsPerKg: int.tryParse(_pointsController.text)!,
        weight: 0,
      );
      context
          .read<ItemsBloc>()
          .add(UpdateItem(product: productModule));
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
        title: const Text("Add item"),
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
                      child: PickImageWidget(image: _selectedImage),
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
                        controller: _pointsController),
                    const SizedBox(height: 20),
                    BlocProvider(
                      create: (context) =>
                          ItemsBloc(repository: ItemsRepository()),
                      child: ElevatedButton(
                        onPressed: addItem,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.blueAccent[100], // background color
                          padding: const EdgeInsets.all(18.0), // padding
                        ),
                        child: const Text(
                          "Add",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
