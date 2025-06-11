import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sharify_flutter_app/presentation/pages/user/user_home.dart';

void main() {
  testWidgets('UserHomePage renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: UserHomePage(),
        ),
      ),
    );
    expect(find.byType(UserHomePage), findsOneWidget);
  });
}
