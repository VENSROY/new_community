import 'package:flutter/material.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings"), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 35, child: Icon(Icons.person, size: 40)),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Maya Raj Jain", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("9876543210", style: TextStyle(color: Colors.grey)),
                ],
              )
            ],
          ),
          const SizedBox(height: 30),
          _item(Icons.person_outline, "Personal Details"),
          _item(Icons.location_on_outlined, "Address Details"),
          _item(Icons.people_outline, "Family Details"),
          const Divider(height: 40),
          _item(Icons.privacy_tip_outlined, "Privacy Policy"),
          _item(Icons.help_outline, "Help & Support"),
          _item(Icons.lock_reset, "Reset Pin"),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/'),
              style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.black12)),
              child: const Text("LOGOUT", style: TextStyle(color: Colors.black)),
            ),
          )
        ],
      ),
    );
  }

  Widget _item(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}