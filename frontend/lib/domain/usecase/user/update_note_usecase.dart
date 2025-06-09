import '../../repositories/item_repository.dart';

class UpdateNoteUseCase {
  final ItemRepository itemRepository;

  UpdateNoteUseCase(this.itemRepository);

  Future<bool> execute(String itemId, String note) async {
    return await itemRepository.updateNote(itemId, note);
  }
}