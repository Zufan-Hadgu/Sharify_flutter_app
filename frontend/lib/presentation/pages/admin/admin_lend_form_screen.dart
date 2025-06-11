import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/provider/admin_item_provider.dart';
import '../../../domain/entities/item_entity.dart';
import '../../providers/admin/admin_provider.dart';

class AdminLendingForm extends ConsumerStatefulWidget {
  final VoidCallback onSubmit;

  const AdminLendingForm({required this.onSubmit, super.key});

  @override
  ConsumerState<AdminLendingForm> createState() => _AdminLendingFormState();
}

class _AdminLendingFormState extends ConsumerState<AdminLendingForm> {
  final _nameController = TextEditingController();
  final _smallDescriptionController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _termsController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _addressController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    if (!mounted) return;
    if (_image == null || _nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Please provide all required fields")),
      );
      return;
    }

    final notifier = ref.read(adminProvider.notifier);
    final item = ItemEntity(
      id: DateTime.now().toString(),
      name: _nameController.text,
      image: "",
      smalldescription: _smallDescriptionController.text,
      description: _descriptionController.text,
      termsAndConditions: _termsController.text,
      telephon: _telephoneController.text,
      address: _addressController.text,
    );

    try {
      final multipartImage =
      await MultipartFile.fromFile(_image!.path, filename: "item_image.jpg");
      await notifier.addAdminItem(item, multipartImage, () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Item added successfully!")),
        );
        context.go('/lending');
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Error adding item: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lend Item"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("List an item", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text("Please provide the details of your item below", style: TextStyle(color: Colors.grey)),

            const SizedBox(height: 24),

            Row(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _image == null
                        ? const Center(child: Icon(Icons.photo_camera, size: 40))
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(_image!, fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.upload),
                  label: const Text("Upload Image"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF005D73),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            const Text("Item Info", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            _buildTextField("Name*", Icons.edit, _nameController),
            _buildTextField("Short Description*", Icons.short_text, _smallDescriptionController),
            _buildTextField("Description*", Icons.description, _descriptionController),
            _buildTextField("Terms and Conditions*", Icons.rule, _termsController), // ✅ Added this line

            const SizedBox(height: 24),
            const Text("Contact Info", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            _buildTextField("Phone Number", Icons.phone_iphone, _telephoneController),
            _buildTextField("Address", Icons.place, _addressController),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF005D73),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text("Submit", style: TextStyle(fontSize: 16)),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
