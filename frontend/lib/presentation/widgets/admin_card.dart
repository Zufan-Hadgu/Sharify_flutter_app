import 'package:flutter/material.dart';

class AdminItemCard extends StatelessWidget {
  final String itemId;
  final String title;
  final String smallDescription;
  final String imageUrl;
  final bool isAvailable; // ✅ Dynamic availability
  final VoidCallback onEditClick;
  final VoidCallback onDeleteClick;

  const AdminItemCard({
    required this.itemId,
    required this.title,
    required this.smallDescription,
    required this.imageUrl,
    required this.isAvailable, // ✅ Dynamic availability
    required this.onEditClick,
    required this.onDeleteClick,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Color(0xFFdbdbdb), width: 2),
      ),
      elevation: 4,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text(smallDescription, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                  const SizedBox(height: 12),

                  // Availability Status with Dynamic Color
                  Text(
                    isAvailable ? "Status: Available" : "Status: Unavailable",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isAvailable ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onEditClick,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF005D73),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          child: const Text("Edit", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: onDeleteClick,
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF005D73)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          child: const Text("Cancel", style: TextStyle(color: Color(0xFF005D73))),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 16),

            // Item Image with Emulator Fix
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl.replaceAll("localhost", "10.0.2.2"),
                width: 88,
                height: 88,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 88,
                  height: 88,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.image, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}