import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../login/views/login_view.dart';

class ProfileController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;
  var image = Rx<File?>(null);

  Future<void> uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);

      try {
        final storageRef = _storage.ref('profile/${DateTime.now()}.png');
        final uploadTask = storageRef.putFile(image.value!);

        await uploadTask.whenComplete(
            () => Get.snackbar('Success', 'Image uploaded successfully'));
      } catch (e) {
        Get.snackbar('Error', 'Failed to upload image: $e');
      }
    } else {
      Get.snackbar('Error', 'No image selected');
    }
  }

  void logout() async {
    await auth.signOut();
    Get.off(() => LoginView());
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      try {
        final userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        if (userData.exists) {
          return userData.data() as Map<String, dynamic>;
        }
      } catch (e) {
        print('Error retrieving user data: $e');
        return null;
      }
    }
    return null;
  }
}
