import 'package:flutter/material.dart';

void showBorrowingNoteDialog({
  required BuildContext context,
  required String itemId,
  required String initialNote,
  required Function(String) onUpdateNote,
}) {
  TextEditingController noteController = TextEditingController(text: initialNote);

  showDialog(
    context: context,
    builder: (BuildContext dialogContext) { // ✅ Use unique context for nested dialogs
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "🗓️ My Note on this Item",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF005D73)),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Color(0xFF005D73)),
              onPressed: () => Navigator.pop(dialogContext), // ✅ Ensures correct dismissal context
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: noteController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: "Write your note...",
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF005D73))),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF005D73))),
              ),
            ),
          ],
        ),
        actions: [
          Center( // ✅ Ensures button is fully centered
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ElevatedButton(
                onPressed: () {
                  if (noteController.text.trim().isNotEmpty) {
                    onUpdateNote(noteController.text);
                    Navigator.pop(dialogContext);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("✅ Note Updated Successfully!")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("⚠ Please enter a note before updating.")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF005D73),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
                child: const Text("Update", style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      );
    },
  );
}