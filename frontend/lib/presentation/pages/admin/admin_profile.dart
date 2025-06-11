import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../auth/base_screen.dart';

class AdminProfileScreen extends StatefulWidget {
  @override
  _AdminProfileScreenState createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  String name = "";
  String email = "";
  XFile? selectedImage;
  final ImagePicker imagePicker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = image;
      });
    }
  }

  void saveChanges() {
    // Simulate saving changes
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Changes saved!")));
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      role: "admin",
      currentRoute: "/admin-profile",
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: selectedImage != null
                  ? ClipOval(child: Image.file(File(selectedImage!.path), fit: BoxFit.cover))
                  : Icon(Icons.person, size: 80, color: Colors.white),
            ),

            SizedBox(height: 16),

            // Change Picture Button
            ElevatedButton.icon(
              onPressed: pickImage,
              icon: Icon(Icons.camera_alt),
              label: Text("Change Picture"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF005D73),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),

            SizedBox(height: 32),

            // Editable Input Fields
            ProfileInputField(label: "Name", value: name, onChanged: (newName) => setState(() => name = newName)),
            SizedBox(height: 16),
            ProfileInputField(label: "Email", value: email, onChanged: (newEmail) => setState(() => email = newEmail)),

            SizedBox(height: 32),

            // Save Changes Button
            ElevatedButton(
              onPressed: saveChanges,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF005D73),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text("Save Changes", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileInputField extends StatelessWidget {
  final String label;
  final String value;
  final Function(String) onChanged;

  ProfileInputField({required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onChanged: onChanged,
      controller: TextEditingController(text: value),
    );
  }
}