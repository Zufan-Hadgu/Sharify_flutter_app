import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/user/item_detail_notifier.dart';

class ItemDetailPage extends ConsumerWidget {
  final String id;

  const ItemDetailPage({required this.id, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(itemDetailNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(item?.name ?? "Item Details"),
        leading: IconButton(onPressed: () => context.pop(), icon: Icon(Icons.arrow_back)),
      ),
      body: item == null
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Image.network(item.image),
          Text(item.description),
          Text("Terms: ${item.termsAndConditions}"),
          Text("Address: ${item.address}"),
          Text("Telephone: ${item.telephon}"),
        ],
      ),
    );
  }
}