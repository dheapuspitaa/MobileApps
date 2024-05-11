import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  Future<void> register(
    String fullName,
    String address,
    String phoneNumber,
    String email,
    String password,
  ) async {
    if (formKey.currentState!.validate()) {
      if (password.length < 6 || password.length > 12) {
        Get.snackbar('Error', 'Password must be between 6 and 12 characters.');
        return;
      }
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid)
            .set({
          'full_name': fullName,
          'address': address,
          'phone_number': phoneNumber,
          'email': email,
        });

        Get.snackbar('Success', 'User created successfully');
        sendEmailVerification(userCredential.user!);
      } on FirebaseAuthException catch (e) {
        print('FirebaseAuthException occurred: ${e.code}');
        if (e.code == 'weak-password') {
          Get.snackbar('Error', 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar('Error', 'The account already exists for that email.');
        }
        print(e.code);
      } catch (e) {
        print('An error occurred during register: $e');
      }
    }
  }

  Future<void> sendEmailVerification(User user) async {
    await user.sendEmailVerification();
    Get.defaultDialog(
      title: 'Verify your email',
      middleText:
          'Please verify your email to continue. We have sent you an email verification link.',
      textConfirm: 'OK',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.offAllNamed(Routes.LOGIN);
      },
    );
  }

  @override
  void onClose() {
    fullNameController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
