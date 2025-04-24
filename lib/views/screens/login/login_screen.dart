import 'package:admin_panel/viewmodels/login_viewmodel.dart';
import 'package:admin_panel/views/screens/main_screen.dart';
import 'package:admin_panel/views/widgets/login/login_button.dart';
import 'package:admin_panel/views/widgets/login/login_textfield.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginViewmodel viewmodel = LoginViewmodel();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Admin Panel",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          Form(
            key: formkey,
            child: Column(
              spacing: 20,
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Lottie.asset("assets/lottie/hi-person.json"),
                        Positioned(
                          bottom: 40,
                          right: 0,
                          left: 0,
                          child: Center(
                            child: Text(
                              "HEY SUP WELCOME",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                LoginTextField(
                  controller: viewmodel.loginController,
                  isPassword: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Loginni kiriting';
                    }
                    if (value.length < 4) {
                      return "Login kamida 3ta harfdan iborat bo'lishi kerak";
                    }
                    return null;
                  },
                ),

                LoginTextField(
                  controller: viewmodel.passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Parolni kiriting';
                    }
                    if (value.length < 4) {
                      return "Parol kamida 6 belgidan iborat bo'lishi kerak";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                LoginButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      bool isValid = await viewmodel.validateLogin();
                      if (isValid) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Incorrect login or password!",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
