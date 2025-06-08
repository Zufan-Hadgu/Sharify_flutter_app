class ItemEntity {
  final String id;
  final String name;
  final String image;
  final String smalldescription;
  final String description;
  final bool isAvailable;
  final String termsAndConditions;
  final String telephon;
  final String address;

  ItemEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.smalldescription,
    required this.description,
    required this.isAvailable,
    required this.termsAndConditions,
    required this.telephon,
    required this.address,
  });
}
