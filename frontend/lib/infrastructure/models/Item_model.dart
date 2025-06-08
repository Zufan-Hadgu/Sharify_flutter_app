import '../../core/utils/fix_image_url.dart';
import '../../domain/entities/item_entity.dart';

class ItemModel {
  final String id;
  final String name;
  final String image;
  final String smalldescription;
  final String description;
  final bool isAvailable;
  final String termsAndConditions;
  final String telephon;
  final String address;
  final String note;

  ItemModel({
    required this.id,
    required this.name,
    required this.image,
    required this.smalldescription,
    required this.description,
    required this.isAvailable,
    required this.termsAndConditions,
    required this.telephon,
    required this.address,
    required this.note
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
    id: json['id'],  // ✅ Change '_id' to 'id'
    name: json['name'],
    image: fixImageUrl(json['image']),
    smalldescription: json['smalldescription'],
    description: json['description'] ?? '',  // ✅ Handle missing fields
    isAvailable: json['isAvailable'] == 1,
    termsAndConditions: json['termsAndConditions'] ?? '',
    telephon: json['telephon'] ?? '',
    address: json['address'] ?? '',
    note: json['note'] ?? '',
  );


  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'smalldescription': smalldescription,
    'description': description,
    'isAvailable': isAvailable,
    'termsAndConditions': termsAndConditions,
    'telephon': telephon,
    'address': address,
    'note': note,
  };


  ItemEntity toEntity() => ItemEntity(
    id: id,
    name: name,
    image: image,
    smalldescription: smalldescription,
    description: description,
    isAvailable: isAvailable,
    termsAndConditions: termsAndConditions,
    telephon: telephon,
    address: address,
    note: note,
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
  );
}
