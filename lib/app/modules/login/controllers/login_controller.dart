import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Stream<User?> get streamAuthStatus =>
      FirebaseAuth.instance.authStateChanges();

  void login(String email, String password) async {
    if (formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        if (userCredential.user!.emailVerified) {
          Get.snackbar('Success', 'User logged in successfully');
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.snackbar('Error', 'Please verify your email');
        }
      } on FirebaseAuthException catch (e) {
        print('FirebaseAuthException occurred: ${e.code}');
        if (e.code == 'user-not-found') {
          print('wrong email');
          Get.snackbar('Error', 'No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('wrong password');
          Get.snackbar('Error', 'Wrong password provided for that user.');
        } else if (e.code == 'too-many-requests') {
          print('too-many-requests');
          Get.snackbar('Error', 'Too many requests. Try again later.');
        }
        print(e.code);
      } catch (e) {
        print('An error occurred during login: $e');
      }
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
