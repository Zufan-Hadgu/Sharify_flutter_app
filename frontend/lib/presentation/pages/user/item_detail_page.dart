import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/user/item_detail_notifier.dart';


class ItemDetailPage extends ConsumerWidget {
  final String id;

  const ItemDetailPage({required this.id, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(itemDetailNotifierProvider.notifier);
    final item = ref.watch(itemDetailNotifierProvider);

    Future.delayed(Duration.zero, () => notifier.fetchItemDetails(id));
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
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: 4,
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return _buildImage(item.image);
              case 1:
                return _buildTitle(item.name);
              case 2:
                return _buildStyledSection("Description", item.description ?? "No description available");
              case 3:
                return _buildStyledSection("Terms and Conditions", item.termsAndConditions ?? "No terms provided");
              case 4:
                return _buildStyledSection(
                    "Contact Info",
                    "📞 ${item.telephon ?? "No phone available"}\n📍 ${item.address ?? "No address available"}");
              default:
                return SizedBox();
            }
          },
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