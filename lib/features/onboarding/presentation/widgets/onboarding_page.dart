import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const OnboardingPage({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ],
    );
  }
}
