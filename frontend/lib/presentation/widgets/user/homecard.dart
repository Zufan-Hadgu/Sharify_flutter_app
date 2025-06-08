import 'package:flutter/material.dart';
import '../../../core/utils/fix_image_url.dart';

class HomeCard extends StatelessWidget {
  final String id;
  final String name;
  final String smallDescription;
  final String image;
  final VoidCallback onBorrow;
  final VoidCallback onTap;

  const HomeCard({
    required this.id,
    required this.name,
    required this.smallDescription,
    required this.image,
    required this.onBorrow,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      margin: EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 0, // Allow the card to shrink if needed
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image section with fixed height
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Image.network(
                      fixImageUrl(image),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(
                            color: Colors.grey[200],
                            child: Icon(Icons.broken_image),
                          ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Name text with limited lines
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                // Description text with limited lines
                Flexible(
                  child: Text(
                    smallDescription.isNotEmpty ? smallDescription : "No description",
                    style: TextStyle(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10),
                // Button at the bottom
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onBorrow,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF005D73),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: Text(
                      "Borrow",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}