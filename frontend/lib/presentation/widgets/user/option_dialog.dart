import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharify_flutter_app/presentation/widgets/user/show_delete_dialog.dart';
import 'package:sharify_flutter_app/presentation/widgets/user/show_logout_dialog.dart';

void showOptionDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.4),
    builder: (BuildContext dialogContext) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85, // ✅ Adjusted width
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Options",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () => Navigator.pop(dialogContext),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildActionButton(
                icon: Icons.logout,
                label: "Logout",
                color: const Color(0xFF00777B),
                onPressed: () {
                  Navigator.pop(dialogContext);
                  showLogoutDialog(context, ref); // ✅ Open logout confirmation dialog
                },
              ),
              const SizedBox(height: 16),
              _buildOutlinedButton(
                icon: Icons.delete_forever,
                label: "Delete Account",
                color: const Color(0xFF00777B),
                onPressed: () {
                  Navigator.pop(dialogContext);
                  showDeleteDialog(context, ref); // ✅ Open delete confirmation dialog
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildActionButton({
  required IconData icon,
  required String label,
  required Color color,
  required VoidCallback onPressed,
}) {
  return ElevatedButton.icon(
    onPressed: onPressed,
    icon: Icon(icon, color: Colors.white),
    label: Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      minimumSize: const Size(double.infinity, 50),
      elevation: 1,
    ),
  );
}

Widget _buildOutlinedButton({
  required IconData icon,
  required String label,
  required Color color,
  required VoidCallback onPressed,
}) {
  return OutlinedButton.icon(
    onPressed: onPressed,
    icon: Icon(icon, color: color),
    label: Text(label, style: TextStyle(color: color, fontSize: 16)),
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      side: BorderSide(color: color),
      minimumSize: const Size(double.infinity, 50),
      foregroundColor: color,
    ),
  );
}