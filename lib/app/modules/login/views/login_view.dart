import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 23, 23, 23),
      body: Center(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: 400,
              height: 500,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    "LOGIN",
                    style: GoogleFonts.merriweather(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 23, 23, 23),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: controller.emailController,
                    cursorColor: const Color.fromARGB(255, 23, 23, 23),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 86, 85, 85),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 23, 23, 23),
                        ),
                      ),
                      hintText: "Email",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please fill your email';
                      } else if (!GetUtils.isEmail(value)) {
                        return 'Enter valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: controller.passwordController,
                    cursorColor: const Color.fromARGB(255, 23, 23, 23),
                    obscureText: true,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 86, 85, 85),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 23, 23, 23),
                        ),
                      ),
                      hintText: "Password",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please fill your Password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 23, 23, 23),
                      minimumSize: const Size(400, 50),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: GoogleFonts.merriweather(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () => controller.login(
                      controller.emailController.text,
                      controller.passwordController.text,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Doesn't have an account?",
                        style: GoogleFonts.merriweather(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 23, 23, 23),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.offAllNamed('/register');
                        },
                        child: Text(
                          "Create account",
                          style: GoogleFonts.merriweather(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
