import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

// States
abstract class AuthState extends Equatable {
  const AuthState();
}

// init state
class AuthInitialState extends AuthState {
  @override
  List<Object?> get props => [];
}

// signed in state
class AuthSignedInState extends AuthState {
  final User user;

  const AuthSignedInState({
    required this.user,
  });
  @override
  List<Object?> get props => [user];
}

// signed up state
class AuthSignedUpState extends AuthState {
  final User user;
  const AuthSignedUpState({required this.user,});
  @override
  List<Object?> get props => [user];
}

// signed out state
class AuthSignedOutState extends AuthState {
  @override
  List<Object?> get props => [];
}

// error state
class AuthErrorState extends AuthState {
  final String error;
  const AuthErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}
