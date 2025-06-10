import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/provider/provider.dart';

void showDeleteDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Confirm Account Deletion"),
      content: const Text("Are you sure you want to delete your account? This action cannot be undone."),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () async {
            Navigator.pop(context); // ✅ Close delete dialog
            _handleDeleteAccount(context, ref); // ✅ Execute delete process
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text("Delete", style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}

void _handleDeleteAccount(BuildContext context, WidgetRef ref) async {
  await ref.read(authNotifierProvider.notifier).deleteAccount(); // ✅ Use async execution
}