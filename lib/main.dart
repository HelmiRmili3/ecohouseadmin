import 'package:admin/core/providers.dart';
import 'package:admin/core/routes.dart';
import 'package:admin/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('first_time') ?? true;
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // print('Failed to initialize Firebase: $e');
  }
  runApp(MultiBlocProvider(
    providers: getAppProviders(),
    child: MyApp(
      isFirstTime: isFirstTime,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;
  const MyApp({super.key, required this.isFirstTime});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: routes,
      initialRoute: isFirstTime ? Routes.onboarding : Routes.login,
    );
  }
}
