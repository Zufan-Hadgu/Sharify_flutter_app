// test/infrastructure/item_repository_impl_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Import your actual source files here
import 'package:sharify_flutter_app/infrastructure/datasources/remote/item_remote.dart';
import 'package:sharify_flutter_app/infrastructure/datasources/local/item_local.dart';
import 'package:sharify_flutter_app/infrastructure/models/Item_model.dart';

// Annotate the classes to generate mocks
@GenerateMocks([ItemRemoteDataSource, ItemLocalDataSource])
import 'item_repository_impl_test.mocks.dart';

void main() {
  late MockItemRemoteDataSource mockRemoteDataSource;
  late MockItemLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockItemRemoteDataSource();
    mockLocalDataSource = MockItemLocalDataSource();
  });

  group('borrowItem', () {
    final testItemId = 'item1';
    final testUserId = 'user1';
    final testToken = 'token123';
    final testItem = ItemModel(
      id: testItemId,
      name: 'Test Item',
      image: 'image.png',
      smalldescription: 'desc',
      description: 'full desc',
      isAvailable: true,
      termsAndConditions: 'terms',
      telephon: '12345',
      address: 'address',
      note: '',
    );

    test('should call borrowItem on remote datasource', () async {
      when(mockRemoteDataSource.borrowItem(any, any))
          .thenAnswer((_) async => true);

      await mockRemoteDataSource.borrowItem(testItemId, testToken);

      verify(mockRemoteDataSource.borrowItem(testItemId, testToken)).called(1);
    });

    test('should call borrowItemLocally on local datasource', () async {
      when(mockLocalDataSource.borrowItemLocally(any, any))
          .thenAnswer((_) async => true);

      await mockLocalDataSource.borrowItemLocally(testItemId, testUserId);

      verify(mockLocalDataSource.borrowItemLocally(testItemId, testUserId)).called(1);
    });

  });
}
