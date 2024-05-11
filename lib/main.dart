import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/modules/login/controllers/login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAYK6GMLqdNzA2g3IWN3ZXO2ev5lvLD3eo",
      appId: "1:501130029953:android:88b1a1540ed55731ead680",
      messagingSenderId: "501130029953",
      projectId: "artverse-b3563",
      storageBucket: "gs://artverse-b3563.appspot.com",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(LoginController(), permanent: true);

  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authC.streamAuthStatus,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          print(snapshot);
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "ARTVERSE",
            initialRoute:
                snapshot.data != null && snapshot.data!.emailVerified == true
                    ? Routes.HOME
                    : Routes.LOGIN,
            getPages: AppPages.routes,
          );
        }
        return const LoadingView();
      },
    );
  }
}
