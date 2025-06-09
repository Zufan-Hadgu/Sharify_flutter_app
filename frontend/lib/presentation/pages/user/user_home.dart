import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/provider/item_provider.dart';
import '../../../core/utils/SaveJWT.dart';
import '../../widgets/user/homecard.dart';
import '../auth/base_screen.dart';

class UserHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(itemNotifierProvider);
    var searchQuery = '';

    return Scaffold(
      body: BaseScreen( // ✅ Removed `SafeArea` wrapper
        role: "user",
        currentRoute: "/user_home",
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: TextField(
                onChanged: (query) { searchQuery = query; },
                decoration: InputDecoration(
                  hintText: "Search items...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),

            Expanded( // ✅ Ensures content fits properly
              child: state.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : state.error != null
                  ? Center(child: Text(state.error!))
                  : GridView.builder(
                padding: EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.75, // ✅ Prevents stretched cards
                ),
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return HomeCard(
                    id: item.id,
                    name: item.name,
                    smallDescription: item.smalldescription ?? '',
                    image: item.image,
                    onBorrow: () async {
                        ref.read(itemNotifierProvider.notifier).borrowItem(
                            item.id
                        );

                    },
                    onTap: () => GoRouter.of(context).push('/item-detail', extra: {"id": item.id}),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}