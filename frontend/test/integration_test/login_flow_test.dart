import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharify_flutter_app/presentation/pages/auth/login_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login flow test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: LoginPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final emailField = find.byKey(const Key('email'));
    final passwordField = find.byKey(const Key('password'));
    final signInButton = find.widgetWithText(ElevatedButton, 'Sign In');

    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'password123');
    await tester.tap(signInButton);
    await tester.pumpAndSettle();

    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(signInButton, findsOneWidget);
  });
}
