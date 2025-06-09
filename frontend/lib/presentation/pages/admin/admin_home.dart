import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../providers/admin/admin_dashboard_provider.dart';
import '../auth/base_screen.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(adminDashboardProvider);

    return BaseScreen(
      role: "admin",
      currentRoute: '/admin_home',
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatTile(
                  icon: Icons.person_add_alt,
                  label: 'Total active users',
                  value: state.isLoading ? '...' : state.totalUsers.toString(),
                ),
                _buildStatTile(
                  icon: Icons.inventory_2,
                  label: 'Available items',
                  value: state.isLoading ? '...' : state.totalItems.toString(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32.0, 50.0, 32.0, 0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004F5D),
                  ),
                  icon: const Icon(Icons.rate_review_outlined),
                  onPressed: () {
                    // TODO: Navigate to review items page
                  },
                  label: const Text("Review Items"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, size: 30),
        const SizedBox(height: 10),
        Text(label, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF004F5D),
          ),
        ),
      ],
    );
  }
}
