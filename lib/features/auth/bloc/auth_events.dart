import 'dart:io';

import 'package:equatable/equatable.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthSignInEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthSignInEvent({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

class AuthSignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final File imageUrl;
  const AuthSignUpEvent(
    this.name,
    this.imageUrl, {
    required this.email,
    required this.password,
  });
  @override
  List<Object?> get props => [email, password];
}

class AuthSignOutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}
