import 'dart:io';

import 'package:admin/features/auth/presentation/widgets/custom_form_field.dart';
import 'package:admin/features/items/bloc/items_bloc.dart';
import 'package:admin/features/items/modules/product.dart';
import 'package:admin/features/items/repository/items_repository.dart';
import 'package:admin/shared/repository/shared_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/app_utils.dart';
import '../../bloc/items_events.dart';
import '../widgets/pick_image_widget.dart';

class UpdateItemPage extends StatefulWidget {
  final String id;
  final String image;
  final String name;
  final int pointsPerKg;
  const UpdateItemPage(
      {super.key,
      required this.id,
      required this.image,
      required this.name,
      required this.pointsPerKg});

  @override
  State<UpdateItemPage> createState() => _UpdateItemPageState();
}

class _UpdateItemPageState extends State<UpdateItemPage> {
  File? _selectedImage;
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _pointsController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _pointsController =
        TextEditingController(text: widget.pointsPerKg.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _pointsController.dispose();
    super.dispose();
  }

  Future<void> updateItem() async {
    try {
      ProductModule productModule = ProductModule(
        id: widget.id,
        name: _nameController.text,
        pointsPerKg: int.tryParse(_pointsController.text)!,
        image: widget.image,
        weight: 0,
      );
      context.read<ItemsBloc>().add(UpdateItem(
            product: productModule,
            image: _selectedImage,
          ));
      Navigator.of(context).pop();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update item"),
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
                      placeholderImage: widget.image,
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
                    create: (context) => ItemsBloc(
                        repository: ItemsRepository(),
                        sharedRepository: SharedRepository()),
                    child: ElevatedButton(
                      onPressed: updateItem,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.blueAccent[100], // background color
                        padding: const EdgeInsets.all(18.0), // padding
                      ),
                      child: const Text(
                        "Update",
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
