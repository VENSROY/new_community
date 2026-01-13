import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 70),

          Image.asset(
            'assets/images/1.png',
            height: 140,
          ),

          const SizedBox(height: 12),

          const Text(
            'BRANDLOGO',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Text(
            'YOUR TAGLINE',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),

          const Spacer(),

          const Text(
            'Welcome to Community App',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Stay connected with your family, friends, and community.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
              ),
            ),
          ),

          const SizedBox(height: 40),

          /// LOGIN BUTTON
          _button(
            text: 'Login',
            bg: const Color(0xFFFFD151),
            fg: Colors.black,
            onPressed: () {
              Navigator.pushNamed(context, '/mobile');
            },
          ),

          const SizedBox(height: 15),

          _button(
            text: 'Register',
            bg: const Color(0xFF5E1725),
            fg: Colors.white,
            onPressed: () {
              // TODO: Add register navigation
              // Navigator.pushNamed(context, '/register');
            },
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  /// REUSABLE BUTTON
  Widget _button({
    required String text,
    required Color bg,
    required Color fg,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: bg,
            foregroundColor: fg,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
