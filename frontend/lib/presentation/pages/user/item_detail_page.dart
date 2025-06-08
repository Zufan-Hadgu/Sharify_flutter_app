import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/user/item_detail_notifier.dart';

class ItemDetailPage extends ConsumerStatefulWidget {
  final String id;

  const ItemDetailPage({required this.id, super.key});

  @override
  ConsumerState<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends ConsumerState<ItemDetailPage> {
  @override
  void initState() {
    super.initState();
    // Fetch the item details once when the page is first built
    Future.microtask(() =>
        ref.read(itemDetailNotifierProvider.notifier).fetchItemDetails(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    final item = ref.watch(itemDetailNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Item Profile", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: item == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            _buildImage(item.image),
            _buildTitle(item.name),
            _buildStyledSection("Description", item.description ?? "No description available"),
            _buildStyledSection("Terms and Conditions", item.termsAndConditions ?? "No terms provided"),
            _buildStyledSection(
              "Contact Info",
              "📞 ${item.telephon ?? "No phone available"}\n📍 ${item.address ?? "No address available"}",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        imageUrl,
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  Widget _buildStyledSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
          SizedBox(height: 4),
          Text(content, style: TextStyle(fontSize: 16, color: Colors.black54)),
        ],
      ),
    );
  }
}
