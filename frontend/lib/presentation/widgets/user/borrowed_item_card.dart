import 'package:flutter/material.dart';
import '../../../domain/entities/item_entity.dart';

class BorrowedItemCard extends StatelessWidget {
  final ItemEntity item;
  final void Function(String itemId, String initialNote) onAddNoteClick;
  final VoidCallback onDeleteClick;

  const BorrowedItemCard({
    required this.item,
    required this.onAddNoteClick,
    required this.onDeleteClick,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: Theme.of(context).textTheme.titleMedium),
                  Text(item.smalldescription ?? "No description",
                      style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 4),
                  Text("Status: Available",
                      style: Theme.of(context).textTheme.bodySmall),


                  if (item.note?.isNotEmpty ?? false)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text("Note: ${item.note}",
                          style: Theme.of(context).textTheme.bodySmall),
                    ),

                  const SizedBox(height: 8),


                  Row(
                    children: [
                      OutlinedButton.icon(
                        onPressed: () => onAddNoteClick(item.id, item.note ?? ""),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          side: const BorderSide(color: Color(0xFF005D73)),
                        ),
                        icon: const Icon(Icons.edit, size: 18, color: Color(0xFF005D73)),
                        label: const Text("My Note",
                            style: TextStyle(color: Color(0xFF005D73))),
                      ),

                      const SizedBox(width: 8),

                      OutlinedButton(
                        onPressed: onDeleteClick,
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          side: const BorderSide(color: Color(0xFF005D73)),
                        ),
                        child: const Text("Cancel",
                            style: TextStyle(color: Color(0xFF005D73))),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12), // ✅ Spacing

            // ✅ Image (Aligned Right)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}