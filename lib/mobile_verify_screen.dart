import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:new_community/services/api_service.dart'; //  API COMMENTED

class MobileVerifyScreen extends StatefulWidget {
  const MobileVerifyScreen({super.key});

  @override
  State<MobileVerifyScreen> createState() => _MobileVerifyScreenState();
}

class _MobileVerifyScreenState extends State<MobileVerifyScreen> {
  final TextEditingController mobileCtrl = TextEditingController();

  final List<TextEditingController> otpCtrls =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> otpNodes =
  List.generate(6, (_) => FocusNode());

  bool otpSent = true;
  bool canResend = true;
  int cooldown = 30;
  Timer? timer;

  final String fakeOtp = "123456"; //  Fake OTP

  bool get isOtpComplete =>
      otpCtrls.every((c) => c.text.trim().isNotEmpty);

  // ---------------- SEND OTP ----------------
  void sendOtp() {
    // API CALL COMMENTED
    // String response = await ApiService.sendOtp(mobileCtrl.text);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fake OTP sent: 123456')),
    );

    startCooldown();
    FocusScope.of(context).requestFocus(otpNodes[0]);
  }

  // ---------------- COOLDOWN ----------------
  void startCooldown() {
    timer?.cancel();
    canResend = false;
    cooldown = 30;

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (cooldown == 0) {
        t.cancel();
        setState(() => canResend = true);
      } else {
        setState(() => cooldown--);
      }
    });
  }

  // ---------------- VERIFY OTP ----------------
  void verifyOtp() {
    if (!isOtpComplete) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter 6 digit OTP')),
      );
      return;
    }

    String enteredOtp = otpCtrls.map((e) => e.text).join();

    if (enteredOtp == fakeOtp) {
      Navigator.pushReplacementNamed(context, '/pin');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Wrong OTP')),
      );
    }
  }

  // ---------------- OTP BOX ----------------
  Widget otpBox(int index) {
    return SizedBox(
      width: 48,
      child: TextField(
        controller: otpCtrls[index],
        focusNode: otpNodes[index],
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        onChanged: (v) {
          if (v.isNotEmpty && index < 5) {
            otpNodes[index + 1].requestFocus();
          }
          setState(() {});
        },
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }

  // ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F7),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .08),
          child: Column(
            children: [
              const SizedBox(height: 80),

              Image.asset('assets/images/1.png', height: 90),

              const SizedBox(height: 20),

              const Text(
                'Reconnect with your loved ones',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 6),

              const Text(
                'Enter your details to log in.',
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 30),

              TextField(
                controller: mobileCtrl,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  counterText: '',
                  hintText: '9876543210',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, otpBox),
              ),

              const SizedBox(height: 12),

              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: canResend ? sendOtp : null,
                  child: Text(
                    canResend
                        ? 'Resend OTP'
                        : 'Resend in $cooldown sec',
                    style: TextStyle(
                      color: canResend ? Colors.red : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD54F),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Verify Number',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
