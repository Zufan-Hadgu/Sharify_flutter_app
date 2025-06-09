class ItemEntity {
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

  ItemEntity({
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
}