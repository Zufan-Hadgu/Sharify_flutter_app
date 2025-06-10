import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/provider/provider.dart';

void showLogoutDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Confirm Logout"),
      content: const Text("Are you sure you want to log out?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () async {
            Navigator.pop(context); // ✅ Close logout dialog
            _handleLogout(context, ref); // ✅ Execute logout process
          },
          child: const Text("Logout"),
        ),
      ],
    ),
  );
}

void _handleLogout(BuildContext context, WidgetRef ref) async {
  await ref.read(authNotifierProvider.notifier).logout(); // ✅ Use async execution
}
