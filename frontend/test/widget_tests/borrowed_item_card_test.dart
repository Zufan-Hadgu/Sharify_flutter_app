import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sharify_flutter_app/presentation/widgets/user/borrowed_item_card.dart';
import 'package:sharify_flutter_app/domain/entities/item_entity.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('BorrowedItemCard displays item details correctly', (WidgetTester tester) async {
    final item = ItemEntity(
      id: '1',
      name: 'Test Item',
      image: 'test_image.png',
      smalldescription: 'A small description of the item.',
    );

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: BorrowedItemCard(
            item: item,
            onAddNoteClick: (id, note) {},
            onDeleteClick: () {},
          ),
        ),
      );

      expect(find.text('Test Item'), findsOneWidget);
      expect(find.text('A small description of the item.'), findsOneWidget);
    });
  });
}
