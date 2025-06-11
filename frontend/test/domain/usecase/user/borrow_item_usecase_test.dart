import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sharify_flutter_app/domain/repositories/item_repository.dart';
import 'package:sharify_flutter_app/domain/usecase/user/borrow_iem_usecase.dart'; // keep the typo!

import 'borrow_item_usecase_test.mocks.dart';

@GenerateMocks([ItemRepository])
void main() {
  late BorrowItemUseCase useCase;
  late MockItemRepository mockItemRepository;

  setUp(() {
    mockItemRepository = MockItemRepository();
    useCase = BorrowItemUseCase(mockItemRepository);
  });

  test('should call borrowItem on the repository', () async {
    const itemId = '123';

    // Mock the repository's method to return a completed Future
    when(mockItemRepository.borrowItem(itemId)).thenAnswer((_) async {});

    await useCase.execute(itemId);

    verify(mockItemRepository.borrowItem(itemId)).called(1);
    verifyNoMoreInteractions(mockItemRepository);
  });
}
