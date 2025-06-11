// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../providers/admin/admin_provider.dart';
// import '../../providers/admin/admin_state.dart';
// import '../../widgets/admin_card.dart';
// import '../auth/base_screen.dart';
//
// class AdminLendingScreen extends ConsumerStatefulWidget {
//   final VoidCallback onAddItemClick;
//   const AdminLendingScreen({required this.onAddItemClick, super.key});
//
//   @override
//   ConsumerState<AdminLendingScreen> createState() => _AdminLendingScreenState();
// }
//
// class _AdminLendingScreenState extends ConsumerState<AdminLendingScreen> {
//   final TextEditingController searchController = TextEditingController();
//   String searchQuery = "";
//
//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(adminProvider);
//     final filteredItems = state.items
//         .where((item) => item.name.toLowerCase().contains(searchQuery.toLowerCase()))
//         .toList();
//
//     return BaseScreen(
//       role: "admin",
//       currentRoute: '/lending',
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         floatingActionButton: FloatingActionButton(
//           onPressed: widget.onAddItemClick,
//           shape: const CircleBorder(),
//           backgroundColor: const Color(0xFF005D73),
//           child: const Icon(Icons.add, color: Colors.white),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
//           child: Column(
//             children: [
//               // Search Field
//               TextField(
//                 controller: searchController,
//                 onChanged: (value) => setState(() => searchQuery = value),
//                 decoration: InputDecoration(
//                   hintText: 'Search items...',
//                   prefixIcon: const Icon(Icons.search),
//                   filled: true,
//                   fillColor: const Color(0xFFF5F5F5),
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(18),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 18),
//               Expanded(
//                 child: _buildList(state, filteredItems),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildList(AdminState state, List filteredItems) {
//     if (state.isLoading && state.items.isEmpty) {
//       return const Center(child: CircularProgressIndicator());
//     }
//
//     if (state.error != null && state.items.isEmpty) {
//       return Center(child: Text("❌ ${state.error}"));
//     }
//
//     return RefreshIndicator(
//       onRefresh: () => ref.read(adminProvider.notifier).loadAdminItems(),
//       child: ListView.builder(
//         itemCount: filteredItems.length,
//         itemBuilder: (context, index) {
//           final item = filteredItems[index];
//           return AdminItemCard(
//             itemId: item.id,
//             title: item.name,
//             smallDescription: item.smalldescription,
//             imageUrl: item.image,
//             isAvailable: item.isAvailable,
//             onEditClick: () => {},
//             onDeleteClick: () => {},
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/admin/admin_provider.dart';
import '../../providers/admin/admin_state.dart';
import '../../widgets/admin_card.dart';
import '../auth/base_screen.dart';

class AdminLendingScreen extends ConsumerStatefulWidget {
  final VoidCallback onAddItemClick;
  const AdminLendingScreen({required this.onAddItemClick, super.key});

  @override
  ConsumerState<AdminLendingScreen> createState() => _AdminLendingScreenState();
}

class _AdminLendingScreenState extends ConsumerState<AdminLendingScreen> {
  final TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminProvider);
    final filteredItems = state.items
        .where((item) => item.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return BaseScreen(
      role: "admin",
      currentRoute: '/lending',
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: widget.onAddItemClick,
          shape: const CircleBorder(),
          backgroundColor: const Color(0xFF005D73),
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Column(
            children: [
              // Search Field
              TextField(
                controller: searchController,
                onChanged: (value) => setState(() => searchQuery = value),
                decoration: InputDecoration(
                  hintText: 'Search items...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: _buildList(state, filteredItems),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList(AdminState state, List filteredItems) {
    if (state.isLoading && state.items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null && state.items.isEmpty) {
      return Center(child: Text("❌ ${state.error}"));
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(adminProvider.notifier).loadAdminItems(),
      child: ListView.builder(
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          final item = filteredItems[index];
          return AdminItemCard(
            itemId: item.id,
            title: item.name,
            smallDescription: item.smalldescription,
            imageUrl: item.image,
            isAvailable: item.isAvailable,
            onEditClick: () => GoRouter.of(context).go('/edit_item/${item.id}'), // ✅ GoRouter navigation
            onDeleteClick: () async {
              // await ref.read(adminProvider.notifier).deleteItem(item.id); // ✅ Implement delete function
            },
          );
        },
      ),
    );
  }
}