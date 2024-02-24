import 'dart:io';

import 'package:flutter/material.dart';

class PickImageWidget extends StatefulWidget {
  final File? image;

  const PickImageWidget({
    super.key,
    required this.image,
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
                  : Image.asset(
                      'assets/image_placeholder.png',
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
          // Positioned(
          //   bottom: 0,
          //   right: 0,
          //   width: 40,
          //   height: 40,
          //   child: ClipOval(
          //     child: Container(
          //       color: Colors.amber,
          //       child: const IconButton(
          //         onPressed: null,
          //         icon: Icon(Icons.camera),
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
