import 'package:flutter/material.dart';
import 'home_screen.dart';

class ConfirmDetailsScreen extends StatelessWidget {
  final Map<String, String> data;

  const ConfirmDetailsScreen({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: const BackButton(),
        title: const Text(
          'Confirm Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please confirm all the details',
              style: TextStyle(
                color: Color(0xFF7B0F1C),
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 24),

            _sectionTitle(context, 'Community Details', 1),
            _labelValue('Community', data['community']),
            _labelValue('Sub-Community', data['subCommunity']),

            const SizedBox(height: 24),

            _sectionTitle(context, 'Cast Details', 2),
            _labelValue('Cast', data['cast']),

            const SizedBox(height: 24),

            _sectionTitle(context, 'Personal Details', 3),
            _labelValue('First Name', data['firstName']),
            _labelValue('Middle Name', data['middleName']),
            _labelValue('Last Name', data['lastName']),
            _labelValue('Father / Husband Name', data['guardian']),
            _labelValue('Marital Status', data['maritalStatus']),

            const SizedBox(height: 24),

            _sectionTitle(context, 'Address Details', 4),
            _labelValue('Address', data['address']),

            const SizedBox(height: 36),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD54F),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Confirm & Continue',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // ---------------- SECTION TITLE ----------------
  Widget _sectionTitle(BuildContext context, String title, int step) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF7B0F1C),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => HomeScreen(initialStep: step),
                ),
              );
            },
            icon: const Icon(
              Icons.edit,
              size: 18,
              color: Color(0xFF7B0F1C),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- LABEL + VALUE ----------------
  Widget _labelValue(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 13, color: Colors.grey)),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black12),
            ),
            child: Text(
              value?.isNotEmpty == true ? value! : '-',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
