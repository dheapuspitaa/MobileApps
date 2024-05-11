import 'package:artverse/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);

  var selectedIndex = 3.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 23, 23, 23),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: controller.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final userData = snapshot.data;
              return ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 25, left: 20, right: 20),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 32,
                        ),
                        SizedBox(width: 288),
                        Icon(
                          Icons.question_mark_outlined,
                          color: Colors.white,
                          size: 32,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Column(
                    children: [
                      Obx(() {
                        if (controller.image.value != null) {
                          return CircleAvatar(
                            radius: 60,
                            backgroundImage: FileImage(controller.image.value!),
                          );
                        } else {
                          return const CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                          );
                        }
                      }),
                      const SizedBox(height: 25),
                      Text(
                        userData?['full_name'] ?? '',
                        style: GoogleFonts.merriweather(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            userData?['address'] ?? '',
                            style: GoogleFonts.merriweather(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            " | ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            userData?['phone_number'] ?? '',
                            style: GoogleFonts.merriweather(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 60),
                            child: Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    controller.uploadImage();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 69, 69, 69),
                                  ),
                                  child: Text(
                                    "Change Profile",
                                    style: GoogleFonts.merriweather(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    controller.logout();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 69, 69, 69),
                                  ),
                                  child: Text(
                                    "Log Out",
                                    style: GoogleFonts.merriweather(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 19),
                            child: Row(
                              children: [
                                Text(
                                  "Following",
                                  style: GoogleFonts.merriweather(
                                    textStyle: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 170),
                                Text(
                                  "See all",
                                  style: GoogleFonts.merriweather(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 360,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 19),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        AssetImage('assets/artist2.jpeg'),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    "Van Gogh",
                                    style: GoogleFonts.merriweather(
                                      textStyle: const TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 23, 23, 23),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        AssetImage('assets/artist3.jpeg'),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    "Angelica Kauffman",
                                    style: GoogleFonts.merriweather(
                                      textStyle: const TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 23, 23, 23),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        AssetImage('assets/artist5.jpeg'),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    "Artemisia Gentileschi",
                                    style: GoogleFonts.merriweather(
                                      textStyle: const TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 23, 23, 23),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 19),
                            child: Text(
                              "Recent Buy",
                              style: GoogleFonts.merriweather(
                                textStyle: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          width: 360,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Not Purchasing Yet",
                                style: GoogleFonts.merriweather(
                                  textStyle: const TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 23, 23, 23),
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          }
        },
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: const Color.fromARGB(255, 119, 119, 119),
          currentIndex: selectedIndex.value,
          onTap: (int index) {
            if (index == 0) {
              Get.toNamed('/home');
            } else {
              changeTabIndex(index);
            }
          },
          type: BottomNavigationBarType.fixed,
          iconSize: 30,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.square),
              label: 'Collection',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
