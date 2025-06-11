import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:sharify_flutter_app/presentation/widgets/admin_card.dart';

void main() {
  testWidgets('AdminItemCard displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AdminItemCard(
            itemId: 'testItem',
            title: 'Test Title',
            smallDescription: 'A short description',
            imageUrl: 'https://via.placeholder.com/150',
            isAvailable: true,
            onEditClick: () {},
            onDeleteClick: () {},
          ),
        ),
      ),
    );

    expect(find.byType(AdminItemCard), findsOneWidget);
  });
}
