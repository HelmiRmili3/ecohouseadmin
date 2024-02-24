import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repository/auth_repository.dart';
import 'auth_events.dart';
import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc({required this.repository}) : super(AuthInitialState()) {
    on<AuthSignInEvent>(_mapSignInEventToState);
   // on<AuthSignUpEvent>(_mapSignUpEventToState);
    on<AuthSignOutEvent>(_mapSignOutEventToState);
  }

  Stream<AuthState> _mapSignInEventToState(
      AuthSignInEvent event, Emitter<AuthState> emit) async* {
    try {
      // Sign in the user
      User user = await repository.signInWithEmailAndPassword(
        event.email,
        event.password,
      ) as User;

      // Fetch user data from Firestore using userCredential.user.uid
      // UserModule userData =
      //     (await authRepository.fetchUserData()) as UserModule;

      // Emit a state with the user data
      yield AuthSignedInState(user: user);
    } catch (e) {
      yield AuthErrorState(error: e.toString());
    }
  }

  // Stream<AuthState> _mapSignUpEventToState(
  //     AuthSignUpEvent event, Emitter<AuthState> emit) async* {
  //   try {
  //     // Sign up the user
  //    User user =  (await repository.createUser(
  //       event.email,
  //       event.password,
  //       event.name,
  //       event.imageUrl,
  //     )) as User;

  //     // Emit a state with the user data
  //     yield AuthSignedUpState(user: user);
  //   } catch (e) {
  //     yield AuthErrorState(error: e.toString());
  //   }
  // }

  Stream<AuthState> _mapSignOutEventToState(
      AuthSignOutEvent event, Emitter<AuthState> emit) async* {
    try {
      await repository.signOut();
      yield AuthSignedOutState();
    } catch (e) {
      yield AuthErrorState(error: e.toString());
    }
  }
}
