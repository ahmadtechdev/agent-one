import 'package:agent1/common/color_extension.dart';
import 'package:agent1/common_widget/round_botton.dart';
import 'package:agent1/common_widget/round_text_field.dart';
import 'package:agent1/views/authentication/signup.dart';
import 'package:agent1/views/home/travel_service_homepage.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:get/get.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController txtUser = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool _obscurePassword = true;

  String? selectedClient;

  @override
  void dispose() {
    txtUser.dispose();
    txtPassword.dispose();
    super.dispose();
  }

  // Additional validation for empty fields

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff0D13A1),
                  Color.fromARGB(255, 30, 148, 232),
                ],
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Transform.rotate(
              angle: 3.14159, // Equivalent to 180 degrees in radians
              child: CustomPaint(
                size: Size(screenWidth, 100),
                painter: WavesPainter(),
              ),
            ),
          ),

          // Waves at the bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(screenWidth, 100),
              painter: WavesPainter(),
            ),
          ),

          // Main Content - Centered
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 15,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    width: screenWidth * 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/img/logo1.png',
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 12),
                        // Let's Travel Text

                        const SizedBox(height: 8),
                        Text(
                          "Sign In to your Account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: TColors.secondaryText,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Dropdown for client selection
                        // Replace the existing dropdown with:

                        const SizedBox(height: 12),

                        RoundTextField(
                          hintText: "User name",
                          controller: txtUser,
                        ),
                        const SizedBox(height: 12),
                        RoundTextField(
                          hintText: "Password",
                          controller: txtPassword,
                          obscureText: _obscurePassword,
                          right: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: TColors.secondaryText,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        // const SizedBox(height: 8),
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: TextButton(
                        //     onPressed: () {
                        //       Get.offAll(() => const Home());
                        //     },
                        //     child: const Text(
                        //       "Forgot password?",
                        //       style: TextStyle(
                        //         color: Colors.grey,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 12),
                        RoundButton(
                          title: "Login",
                          onPressed: () {
                            Get.off(() => TravelServicesHomePage());
                          },
                        ),

                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () {
                            Get.to(() => SignUpView());
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Don't have an Account? ",
                                style: TextStyle(
                                  color: TColors.secondaryText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: TColors.secondary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.5);

    // Create smooth wave pattern
    for (double i = 0; i <= size.width; i++) {
      path.lineTo(
        i,
        size.height * 0.5 + math.sin(i * 0.02) * 20 + math.cos(i * 0.015) * 15,
      );
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    canvas.drawPath(path, paint);

    // Second wave with different opacity
    final paint2 = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path2 = Path();
    path2.moveTo(0, size.height * 0.6);

    for (double i = 0; i <= size.width; i++) {
      path2.lineTo(
        i,
        size.height * 0.6 + math.cos(i * 0.02) * 15 + math.sin(i * 0.015) * 10,
      );
    }

    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
