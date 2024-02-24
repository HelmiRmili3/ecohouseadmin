import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const CustomFormField({
    Key? key,
    this.validator,
    this.onSaved,
    required this.labelText,
    required this.controller,
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
      ),
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your ${labelText.toLowerCase()}';
            }
            return null;
          },
      onSaved: onSaved,
      controller: controller,
    );
  }
}
