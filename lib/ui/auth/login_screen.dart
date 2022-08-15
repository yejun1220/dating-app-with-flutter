import 'package:dataing_app/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone_android,
                  size: 100,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Hello',
                  style: GoogleFonts.bebasNeue(fontSize: 36.0),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Welcome back',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    AuthController.instance.signInWithGoogle();
                  },
                  child: Obx(
                    () {
                      if (AuthController.instance.isLoading.value) return Center(child: CircularProgressIndicator());

                      return Container(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Text(
                                'Google Sign in',
                                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 25,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
