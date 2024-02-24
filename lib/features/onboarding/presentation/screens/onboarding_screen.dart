import 'package:admin/core/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  final List<Map<String, String>> onboardingData = [
    {
      'title': 'Welcome to MyApp',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX-XW8QqOrlmjRUbzbqwkMoCb61rw6UkkhJPVFT3bWn6_2mFBKslhmxpWo2UUzK_fj1rk&usqp=CAU',
    },
    {
      'title': 'Discover New Features',
      'description':
          'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1Mq8OTXyAemBtQNGOSkiXZnrdph5DBJ_nfyUjiF1eoH7fGydmEkWEWNypGlPTHutpnAw&usqp=CAU',
    },
    {
      'title': 'Get Started Now',
      'description':
          'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwnouU4UvHVrxWIYo71t3QAJvzPceNkPDIll6rNjt_DMyI40OSGfLn621dkIhidOadNpE&usqp=CAU',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingData.length,
            onPageChanged: (int index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final data = onboardingData[index];
              return Stack(
                children: [
                  Image.network(
                    data['imageUrl']!,
                    fit: BoxFit.cover, // Fit image to the screen
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  OnboardingPage(
                    title: data['title']!,
                    description: data['description']!,
                    imageUrl: data['imageUrl']!,
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < onboardingData.length; i++)
                      if (i == _currentPageIndex)
                        _buildStepperDot(isActive: true)
                      else
                        _buildStepperDot(isActive: false),
                  ],
                ),
                const SizedBox(height: 80),
                ElevatedButton(
                  onPressed: () async {
                    if (_currentPageIndex < onboardingData.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    } else {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('first_time', false);
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacementNamed(context, Routes.login);
                    }
                  },
                  child: Text(
                    _currentPageIndex == onboardingData.length - 1
                        ? 'Get Started'
                        : 'Next',
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepperDot({required bool isActive}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.blue : Colors.grey,
      ),
    );
  }
}
