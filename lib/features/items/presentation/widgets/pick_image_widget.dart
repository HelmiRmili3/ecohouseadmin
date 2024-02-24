import 'dart:io';

import 'package:flutter/material.dart';

class PickImageWidget extends StatefulWidget {
  final String placeholderImage;
  final File? image;

  const PickImageWidget({
    super.key,
    required this.image,
    required this.placeholderImage,
  });

  @override
  State<PickImageWidget> createState() => _PickImageWidgetState();
}

class _PickImageWidgetState extends State<PickImageWidget> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: SizedBox(
              width: width, // Adjust width as needed
              height: 300, // Adjust height as needed
              child: widget.image != null
                  ? Image.file(
                      widget.image!,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      widget.placeholderImage,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
