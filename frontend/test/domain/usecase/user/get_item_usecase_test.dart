import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sharify_flutter_app/domain/entities/item_entity.dart';
import 'package:sharify_flutter_app/domain/usecase/user/get_item_usecase.dart';
import 'package:sharify_flutter_app/domain/repositories/item_repository.dart';

import 'get_item_usecase_test.mocks.dart';

@GenerateMocks([ItemRepository])
void main() {
  late GetItemsUseCase useCase;
  late MockItemRepository mockItemRepository;

  setUp(() {
    mockItemRepository = MockItemRepository();
    useCase = GetItemsUseCase(mockItemRepository);
  });

  test('should get list of items from repository', () async {
    final expectedItems = [
      ItemEntity(id: '1', name: 'Item 1', description: 'Description 1', image: 'dummy_image_url',smalldescription: 'Short desc 1'),
      ItemEntity(id: '2', name: 'Item 2', description: 'Description 2', image: 'dummy_image_url', smalldescription: 'Short desc 2',),
    ];

    when(mockItemRepository.getItems()).thenAnswer((_) async => expectedItems as List<ItemEntity>);

    final result = await useCase.execute();

    expect(result, expectedItems);
    verify(mockItemRepository.getItems()).called(1);
    verifyNoMoreInteractions(mockItemRepository);
  });
}
