import 'package:flutter/material.dart';

import 'package:flutter/material.dart';



void showOptionsDialog({
  required BuildContext context,
  required VoidCallback onLogout,
  required VoidCallback onDelete,
  required String userRole,
}) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.4),
    builder: (BuildContext dialogContext) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Center(
                    child: Text(
                      "Options",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(dialogContext),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildActionButton(
                icon: Icons.logout,
                label: "Logout",
                color: const Color(0xFF00777B),
                onPressed: () {
                  onLogout();
                  Navigator.pop(dialogContext);
                },
              ),
              if (userRole != "admin") ...[
                const SizedBox(height: 12),
                _buildOutlinedButton(
                  icon: Icons.delete,
                  label: "Delete",
                  color: const Color(0xFF00777B),
                  onPressed: () {
                    onDelete();
                    Navigator.pop(dialogContext);
                  },
                ),
              ],
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
    label: Text(label, style: const TextStyle(color: Colors.white)),
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      minimumSize: const Size(double.infinity, 50),
      elevation: 0,
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
    label: Text(label, style: TextStyle(color: color)),
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      side: BorderSide(color: color),
      minimumSize: const Size(double.infinity, 50),
    ),
  );
}
