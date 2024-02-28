import 'package:admin/core/constants.dart';
import 'package:admin/core/routes.dart';
import 'package:admin/features/auth/bloc/auth_bloc.dart';
import 'package:admin/features/auth/presentation/widgets/custom_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final String name = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthInitialState) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 130,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Constants.login,
                              style: TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold),
                            ),
                            Divider(
                              color: Colors.black,
                              thickness: 2,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CustomFormField(
                                keyboardType: TextInputType.emailAddress,
                                labelText: "Email",
                                controller: _emailController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomFormField(
                                  keyboardType: TextInputType.text,
                                  labelText: "Password",
                                  controller: _passwordController),
                              const SizedBox(
                                height: 20,
                              ),
                              RichText(
                                textAlign: TextAlign.right,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Forget password",
                                      style: const TextStyle(
                                          color: Colors.blue, fontSize: 16),
                                      // Add an onTap callback to make it clickable
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // Add your sign-in logic here
                                        },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // BlocProvider.of<AuthBloc>(context).add(
                                  //     AuthSignInEvent(
                                  //         email: _emailController.text,
                                  //         password: _passwordController.text));
                                  Navigator.pushReplacementNamed(context, Routes.home);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors
                                      .blueAccent[100], // background color
                                  padding:
                                      const EdgeInsets.all(18.0), // padding
                                ),
                                child: const Text(
                                  Constants.login,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              RichText(
                                textAlign: TextAlign.right,
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "You don't have an account ! ",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                    TextSpan(
                                      text: "SignIn",
                                      style: const TextStyle(
                                          color: Colors.blue, fontSize: 16),
                                      // Add an onTap callback to make it clickable
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // Add your sign-in logic here
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is AuthSignedInState) {
            return Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.home);
                  },
                  child: const Text("Continue")),
            );
          } else {
            return const Center(
              child: Text('error'),
            );
          }
        },
      ),
    );
  }
}
