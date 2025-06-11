import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharify_flutter_app/presentation/pages/auth/login_page.dart';

void main() {
  testWidgets('LoginPage renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: LoginPage(),
        ),
      ),
    );

    // Use pumpAndSettle to wait for all async work to complete
    await tester.pumpAndSettle();

    // Now, check for the presence of the 'Login' text
    expect(find.text('Login'), findsOneWidget);
  });
}
