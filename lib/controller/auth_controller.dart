import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../main.dart';
import '../ui/auth/login_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find<AuthController>();
  late Rx<User?> _user;
  FirebaseAuth authentication = FirebaseAuth.instance;
  var isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(authentication.currentUser);
    _user.bindStream(authentication.userChanges());
    ever(_user, _moveToPage);
  }

  _moveToPage(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => DefaultHome());
    }
  }

  Future<void> signInWithGoogle() async {
    isLoading.value = true;

    // Trigger the authentication flow
    final googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      Get.snackbar(
        "Error message",
        "User message",
        backgroundColor: Colors.red,
        titleText: Text("auth is failed"),
        messageText: Text(
          e.toString(),
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    isLoading.value = false;
  }

  void logout() {
    authentication.signOut();
  }
}
