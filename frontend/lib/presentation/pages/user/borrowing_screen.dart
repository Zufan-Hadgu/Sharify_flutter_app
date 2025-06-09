import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/provider/item_provider.dart';
import '../../../core/utils/SaveJWT.dart';
import '../../widgets/user/add_note.dart';
import '../../widgets/user/borrowed_item_card.dart';
import '../auth/base_screen.dart';

class UserBorrowingScreen extends HookConsumerWidget {
  const UserBorrowingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(itemNotifierProvider);
    useEffect(() {
      Future<void> fetchUserData() async {
        final userId = await getUserIdFromToken();

        if (userId != null && userId.isNotEmpty) {
          ref.read(itemNotifierProvider.notifier).fetchBorrowedItems(userId);
        } else {
          print("❌ No valid user ID found for fetching borrowed items.");
        }
      }

      fetchUserData();
      return null;
    }, []);



    return BaseScreen(
      role: "user",
      currentRoute: '/borrowing',
      child: Scaffold(
        appBar: AppBar(title: const Text("Borrowing History")),

        body: Builder(
          builder: (context) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              return Center(child: Text("❌ ${state.error}"));
            }

            if (state.borrowedItems.isEmpty) {
              return const Center(child: Text("No borrowed items yet."));
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: state.borrowedItems.length,
                itemBuilder: (context, index) {
                  final item = state.borrowedItems[index];
                  return BorrowedItemCard(
                    item: item,
                    onAddNoteClick: (itemId, initialNote) {
                      showBorrowingNoteDialog(
                        context: context,  // ✅ Ensure context is passed correctly
                        itemId: itemId,
                        initialNote: initialNote,
                        onUpdateNote: (updatedNote) {
                          ref.read(itemNotifierProvider.notifier).updateBorrowNote(itemId, updatedNote);
                        },
                      );
                    },
                    onDeleteClick: () {
                      ref.read(itemNotifierProvider.notifier).removeFromBorrowed(item.id);
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
