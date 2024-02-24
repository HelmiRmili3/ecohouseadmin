import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return result.user;
    } catch (e) {
      // Handle errors
      return null;
    }
  }

  Future<User?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      final AuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);

      final UserCredential authResult =
          await _firebaseAuth.signInWithCredential(credential);

      return authResult.user;
    } catch (e) {
      //print('Facebook login failed. Error: ${e}');
      return null;
    }
  }

  // Future<UserCredential?> createUser(
  //     String email, String password, String name, File image) async {
  //   try {
  //     final imageUrl = await uploadImageToFirebaseStorage(image);
  //     final result = await _firebaseAuth
  //         .createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     )
  //         .then((userdata) async {
  //       if (userdata.user != null) {
  //         final user = UserModule(
  //             id: userdata.user!.uid,
  //             name: name,
  //             email: userdata.user!.email ?? '',
  //             credit: 0,
  //             imageUrl: imageUrl);
  //         await addUserDataToFirestore(user);
  //       }
  //     });
  //     return result;
  //   } catch (e) {
  //     // Handle errors
  //     return null;
  //   }
  // }

  // Future<void> addUserDataToFirestore(UserModule user) async {
  //   try {
  //     CollectionReference usersCollection = _firestore.collection('users');
  //     String userId = _firebaseAuth.currentUser!.uid;

  //     DocumentReference userDocRef =
  //         usersCollection.doc(userId).collection('userCredential').doc();
  //     await userDocRef.set(user.toJson());

  //     //print('User data added successfully with ID: ${userDocRef.id}');
  //   } catch (e) {
  //     throw Exception('Failed to add order to Firestore: $e');
  //   }
  // }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<User?> getAuthStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  Future<String> uploadImageToFirebaseStorage(File? imageFile) async {
    if (imageFile == null) return '';

    final storage = FirebaseStorage.instance;
    final Reference storageReference =
        storage.ref().child('images/${DateTime.now().toString()}');
    final UploadTask uploadTask = storageReference.putFile(
      File(imageFile.path),
    );
    await uploadTask.whenComplete(() => null);
    final String imageUrl = await storageReference.getDownloadURL();

    return imageUrl;
  }
}
