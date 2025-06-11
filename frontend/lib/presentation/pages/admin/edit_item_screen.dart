import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../domain/entities/item_entity.dart';
import '../auth/base_screen.dart';
import '../../providers/admin/admin_provider.dart';

class EditItemScreen extends ConsumerStatefulWidget {
  final String itemId;

  const EditItemScreen({required this.itemId, super.key});

  @override
  ConsumerState<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends ConsumerState<EditItemScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController smallDescriptionController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController termsController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  bool isAvailable = true;
  XFile? imageFile;

  @override
  void dispose() {
    nameController.dispose();
    smallDescriptionController.dispose();
    descriptionController.dispose();
    termsController.dispose();
    telephoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage = await picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() => imageFile = selectedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminProvider);
    final item = state.items.firstWhere((i) => i.id == widget.itemId);

    if (item == null) {
      return const Center(child: CircularProgressIndicator());
    }

    nameController.text = item.name;
    smallDescriptionController.text = item.smalldescription ?? "";
    descriptionController.text = item.description ?? "";
    termsController.text = item.termsAndConditions ?? "";
    telephoneController.text = item.telephon ?? "";
    addressController.text = item.address ?? "";
    // isAvailable = item.isAvailable;

    return BaseScreen(
      role: "admin",
      currentRoute: "/edit_item",
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Item"),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Edit item details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text("Update the details of your item below", style: TextStyle(color: Colors.grey)),

              const SizedBox(height: 24),

              // Image Upload
              Row(
                children: [
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: imageFile != null
                          ? Image.file(File(imageFile!.path), fit: BoxFit.cover)
                          : const Icon(Icons.camera_alt, size: 50, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: pickImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF005D73),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text("Update Image", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              const Text("Item Info", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildTextField("Name*", nameController),
              _buildTextField("Short Description*", smallDescriptionController),
              _buildTextField("Description*", descriptionController),
              _buildTextField("Terms & Conditions", termsController),

              const SizedBox(height: 24),

              const Text("Contact Info", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildTextField("Phone Number", telephoneController),
              _buildTextField("Address", addressController),

              const SizedBox(height: 16),

              // Availability Toggle Switch
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Available?", style: TextStyle(fontSize: 16)),
                  Switch(
                    value: isAvailable,
                    onChanged: (value) => setState(() => isAvailable = value),
                    activeColor: const Color(0xFF005D73),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () async {
                  try {
                    await ref.read(adminProvider.notifier).updateItem(
                      itemId: widget.itemId,
                      item: ItemEntity(
                        id: widget.itemId,
                        name: nameController.text,
                        smalldescription: smallDescriptionController.text,
                        description: descriptionController.text,
                        termsAndConditions: termsController.text,
                        telephon: telephoneController.text,
                        address: addressController.text,
                        isAvailable: isAvailable,
                        image: imageFile != null ? imageFile!.path : item.image, // ✅ Ensure image is passed correctly
                      ),
                      image: imageFile != null
                          ? await MultipartFile.fromFile(imageFile!.path, filename: imageFile!.name)
                          : null, // ✅ Convert image to MultipartFile
                      onSuccess: () async {
                        await ref.read(adminProvider.notifier).loadAdminItems(); // ✅ Refresh item list
                        context.go('/lending'); // ✅ Redirect back to lending page after update
                      },
                    );
                  } catch (e) {
                    print("❌ Error updating item: $e");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF005D73),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text("Update Item", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}