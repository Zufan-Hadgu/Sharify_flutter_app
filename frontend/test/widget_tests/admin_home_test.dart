import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';


import 'package:sharify_flutter_app/infrastructure/datasources/remote/admin_remote_datasource.dart';
import 'package:sharify_flutter_app/presentation/pages/admin/admin_home.dart';
import 'package:sharify_flutter_app/presentation/providers/admin/admin_provider.dart';

import 'admin_home_test.mocks.dart';

// Generate the mock class right here:
@GenerateMocks([AdminRemoteDataSource])
void main() {
  late MockAdminRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockAdminRemoteDataSource();
  });

  testWidgets('AdminHome screen renders without crashing', (WidgetTester tester) async {
    // Mock the data source to return dummy data
    when(mockDataSource.fetchDashboardStats()).thenAnswer(
          (_) async => {'totalUsers': 10, 'totalItems': 5}, // Replace with your expected API response
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Provide your mocked data source here
          adminRemoteProvider.overrideWithValue(mockDataSource),
        ],
        child: const MaterialApp(
          home: AdminHomePage(),
        ),
      ),
    );

    await tester.pumpAndSettle(); // Wait for the widget to build

    // Check that the widget renders
    expect(find.byType(AdminHomePage), findsOneWidget);
  });
}
