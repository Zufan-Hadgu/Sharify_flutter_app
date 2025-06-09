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

  ItemEntity copyWith({
    String? id,
    String? name,
    String? image,
    String? smalldescription,
    String? description,
    bool? isAvailable,
    String? termsAndConditions,
    String? telephon,
    String? address,
    String? note,
    String? borrowedBy,
  }) {
    return ItemEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      smalldescription: smalldescription ?? this.smalldescription,
      description: description ?? this.description,
      isAvailable: isAvailable ?? this.isAvailable,
      termsAndConditions: termsAndConditions ?? this.termsAndConditions,
      telephon: telephon ?? this.telephon,
      address: address ?? this.address,
      note: note ?? this.note,
      borrowedBy: borrowedBy ?? this.borrowedBy,
    );
  }
}