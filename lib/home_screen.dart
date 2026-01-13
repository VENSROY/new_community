import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'confirm_details.dart';

class HomeScreen extends StatefulWidget {
  final int initialStep;

  const HomeScreen({super.key, this.initialStep = 1});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int currentStep;
  String maritalStatus = 'Married';

  final ImagePicker _picker = ImagePicker();
  File? _profileImage;

  // STEP 1
  final TextEditingController communityCtrl = TextEditingController();
  final TextEditingController subCommunityCtrl = TextEditingController();

  // STEP 2
  final TextEditingController castCtrl = TextEditingController();

  // STEP 3
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController middleNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController guardianCtrl = TextEditingController();

  // STEP 4
  final TextEditingController houseCtrl = TextEditingController();
  final TextEditingController address1Ctrl = TextEditingController();
  final TextEditingController address2Ctrl = TextEditingController();
  final TextEditingController pincodeCtrl = TextEditingController();
  final TextEditingController cityCtrl = TextEditingController();
  final TextEditingController stateCtrl = TextEditingController();

  final List<String> communityList =
  List.generate(6, (i) => 'Community ${i + 1}');
  final List<String> subCommunityList =
  List.generate(6, (i) => 'Sub Community ${i + 1}');
  final List<String> castList =
  List.generate(6, (i) => 'Cast ${i + 1}');

  @override
  void initState() {
    super.initState();
    currentStep = widget.initialStep;
  }

  Future<void> _pickImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _profileImage = File(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Details'),
        leading: const BackButton(),
        backgroundColor: const Color(0xFFFFF2F2),
        elevation: 0,
      ),
      bottomNavigationBar: _continueButton(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 120),
        child: Column(
          children: [
            const SizedBox(height: 16),
            _stepper(),
            const SizedBox(height: 20),
            if (currentStep == 1) _communityUI(),
            if (currentStep == 2) _castUI(),
            if (currentStep == 3) _personalInfoUI(),
            if (currentStep == 4) _addressUI(),
          ],
        ),
      ),
    );
  }

  // ---------------- STEPPER ----------------
  Widget _stepper() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: List.generate(4, (i) {
          final step = i + 1;
          final active = step <= currentStep;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => currentStep = step),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: step == currentStep ? 18 : 14,
                    backgroundColor:
                    active ? const Color(0xFF7B0F1C) : Colors.grey.shade300,
                    child: Text('$step',
                        style: const TextStyle(color: Colors.white)),
                  ),
                  if (step != 4)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: active
                            ? const Color(0xFF7B0F1C)
                            : Colors.grey.shade300,
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  // ---------------- STEP 1 ----------------
  Widget _communityUI() {
    return Column(
      children: [
        _section(
          'Please select your Community',
          _bottomField(
            communityCtrl,
            'Select Community',
                () => _openBottomSheet(
              'Select Community',
              communityList,
              communityCtrl,
              true,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _section(
          'Please select your Sub - Community',
          _bottomField(
            subCommunityCtrl,
            'Select Sub Community',
                () => _openBottomSheet(
              'Select Sub Community',
              subCommunityList,
              subCommunityCtrl,
              true,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------- STEP 2 ----------------
  Widget _castUI() {
    return _section(
      'Please select your Cast',
      _bottomField(
        castCtrl,
        'Select Cast',
            () => _openBottomSheet(
          'Select Cast',
          castList,
          castCtrl,
          false,
        ),
      ),
    );
  }

  // ---------------- STEP 3 ----------------
  Widget _personalInfoUI() {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: CircleAvatar(
            radius: 52,
            backgroundColor: Colors.grey.shade200,
            backgroundImage:
            _profileImage != null ? FileImage(_profileImage!) : null,
            child: _profileImage == null
                ? const Icon(Icons.add_photo_alternate, size: 36)
                : null,
          ),
        ),
        const SizedBox(height: 10),
        const Text('Add Picture'),
        const SizedBox(height: 20),

        _section('First Name', _textField(firstNameCtrl, 'First Name')),
        _section('Middle Name', _textField(middleNameCtrl, 'Middle Name')),
        _section('Last Name', _textField(lastNameCtrl, 'Last Name')),
        _section(
            'Father / Husband Name',
            _textField(guardianCtrl, 'Father / Husband Name')),

        _section(
          'Marital Status',
          _bottomField(
            TextEditingController(text: maritalStatus),
            maritalStatus,
            _showMaritalSheet,
          ),
        ),
      ],
    );
  }

  // ---------------- STEP 4 ----------------
  Widget _addressUI() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Current Address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        _section('House / Flat No.', _textField(houseCtrl, 'House / Flat No')),
        _section('Address Line 1', _textField(address1Ctrl, 'Address')),
        _section('Address Line 2 (Optional)',
            _textField(address2Ctrl, 'Address')),
        _section('Pincode', _textField(pincodeCtrl, 'Pincode')),
        _section('City', _textField(cityCtrl, 'City')),
        _section('State', _textField(stateCtrl, 'State')),
      ],
    );
  }

  // ---------------- BUTTON ----------------
  Widget _continueButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 56,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            if (currentStep < 4) {
              setState(() => currentStep++);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ConfirmDetailsScreen(
                    data: {
                      'community': communityCtrl.text,
                      'subCommunity': subCommunityCtrl.text,
                      'cast': castCtrl.text,
                      'firstName': firstNameCtrl.text,
                      'middleName': middleNameCtrl.text,
                      'lastName': lastNameCtrl.text,
                      'guardian': guardianCtrl.text,
                      'maritalStatus': maritalStatus,
                      'address':
                      '${houseCtrl.text}, ${address1Ctrl.text}, ${address2Ctrl.text}, ${cityCtrl.text}, ${stateCtrl.text} - ${pincodeCtrl.text}',
                    },
                  ),
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFD54F),
            foregroundColor: Colors.black,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: Text(
            currentStep < 4 ? 'Continue' : 'Review Details',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  // ---------------- COMMON ----------------
  Widget _textField(TextEditingController c, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: c,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _bottomField(
      TextEditingController c, String hint, VoidCallback onTap) {
    return TextField(
      controller: c,
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: const Icon(Icons.keyboard_arrow_down),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _section(String title, Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Color(0xFF7B0F1C),
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  // ---------------- BOTTOM SHEET ----------------
  void _showMaritalSheet() {
    _openBottomSheet(
      'Marital Status',
      ['Married', 'Unmarried', 'Widow', 'Divorced', 'Re-Married'],
      TextEditingController(),
      false,
      onSelect: (v) => setState(() => maritalStatus = v),
    );
  }

  void _openBottomSheet(
      String title,
      List<String> data,
      TextEditingController controller,
      bool search, {
        Function(String)? onSelect,
      }) {
    showModalBottomSheet(
      context: context,
      constraints:
      BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.55),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) {
        List<String> filtered = List.from(data);
        final searchCtrl = TextEditingController();
        return StatefulBuilder(
          builder: (context, setModal) {
            return Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  height: 4,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(height: 12),
                Text(title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                if (search)
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextField(
                      controller: searchCtrl,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search',
                          border: OutlineInputBorder()),
                      onChanged: (v) {
                        setModal(() {
                          filtered = data
                              .where((e) =>
                              e.toLowerCase().contains(v.toLowerCase()))
                              .toList();
                        });
                      },
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (_, i) => ListTile(
                      title: Text(filtered[i]),
                      onTap: () {
                        controller.text = filtered[i];
                        if (onSelect != null) onSelect(filtered[i]);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
