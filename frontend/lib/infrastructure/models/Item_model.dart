import '../../core/utils/fix_image_url.dart';
import '../../domain/entities/item_entity.dart';

class ItemModel {
  final String id;
  final String name;
  final String image;
  final String smalldescription;
  final String? description;
  final bool? isAvailable;
  final String? termsAndConditions;
  final String? telephon;
  final String? address;
  final String? note;
  final String? borrowedBy;

  ItemModel({
    required this.id,
    required this.name,
    required this.image,
    required this.smalldescription,
    this.description,
    this.isAvailable,
    this.termsAndConditions,
    this.telephon,
    this.address,
    this.note,
    this.borrowedBy,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    print("🧾 [ItemModel] Parsing JSON: $json"); // ✅ Debugging step

    return ItemModel(
      id: json['id'] ?? '', // ✅ Handle null by providing default
      name: json['name'] ?? 'Unnamed Item',
      image: fixImageUrl(json['image'] ?? ''),
      smalldescription: json['smalldescription'] ?? 'No small description',
      description: json['description'] ?? '',
      isAvailable: json['isAvailable'] ?? false,
      termsAndConditions: json['termsAndConditions'] ?? '',
      telephon: json['telephon'] ?? '',
      address: json['address'] ?? '',
      note: json['note'] ?? '',
      borrowedBy: json['borrowedBy'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'smalldescription': smalldescription,
    if (description != null) 'description': description,
    if (isAvailable != null) 'isAvailable': isAvailable,
    if (termsAndConditions != null) 'termsAndConditions': termsAndConditions,
    if (telephon != null) 'telephon': telephon,
    if (address != null) 'address': address,
    if (note != null) 'note': note,
    if (borrowedBy != null) 'borrowedBy': borrowedBy,
  };

  ItemEntity toEntity() => ItemEntity(
    id: id,
    name: name,
    image: image,
    smalldescription: smalldescription,
    description: description ?? '',
    isAvailable: isAvailable ?? false,
    termsAndConditions: termsAndConditions ?? '',
    telephon: telephon ?? '',
    address: address ?? '',
    note: note ?? '',
    borrowedBy: borrowedBy,
  );

  factory ItemModel.fromEntity(ItemEntity entity) => ItemModel(
    id: entity.id,
    name: entity.name,
    image: entity.image,
    smalldescription: entity.smalldescription,
    description: entity.description,
    isAvailable: entity.isAvailable,
    termsAndConditions: entity.termsAndConditions,
    telephon: entity.telephon,
    address: entity.address,
    note: entity.note,
    borrowedBy: entity.borrowedBy,
  );
}