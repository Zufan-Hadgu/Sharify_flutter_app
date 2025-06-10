import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/admin/admin_dashboard_notifier.dart';
import '../../providers/admin/admin_dashboard_state.dart';
import '../auth/base_screen.dart';
import '../../providers/admin/admin_dashboard_provider.dart';

class AdminHomePage extends ConsumerWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsState = ref.watch(adminDashboardProvider);
    final notifier = ref.read(adminDashboardProvider.notifier);

    return BaseScreen(
      role: "admin",
      currentRoute: '/admin_home',
      child: Center(
        child: statsState.isLoading
            ? const CircularProgressIndicator(color: Color(0xFF005D73))
            : statsState.error != null
            ? Text("❌ Error: ${statsState.error}", style: const TextStyle(color: Colors.red))
            : _buildDashboardContent(statsState, notifier),
      ),
    );
  }

  Widget _buildDashboardContent(AdminDashboardState statsState, AdminDashboardNotifier notifier) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatCard(Icons.people, "Total active users", statsState.totalUsers),
            _buildStatCard(Icons.storage, "Total items", statsState.availableItems),
          ],
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF005D73),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const Text("📋 Review Items", style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ],
    );
  }

  Widget _buildStatCard(IconData icon, String title, int count) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF005D73), size: 56),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Text("$count", style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Color(0xFF005D73))),
      ],
    );
  }
}