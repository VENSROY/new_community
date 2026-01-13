import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _sendOtpUrl =
      'https://marwartechnosoft.com/community_portal/send_otp.php';

  static Future<String> sendOtp(String mobile) async {
    try {
      final response = await http.post(
        Uri.parse(_sendOtpUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "mobile": mobile,
        }),
      );

      print("RAW API RESPONSE ==> ${response.body}");

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "API Failed: ${response.statusCode}";
      }
    } catch (e) {
      return "Error: $e";
    }
  }
}
