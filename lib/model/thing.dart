class Thing {
  Thing({
    required this.id,
    required this.ownerId,
    required this.name,
    this.images = const [],
  });

  final String id;

  final String ownerId;

  final String name;

  final List<String> images;

  factory Thing.fromData(Map<String, dynamic> data) {
    return Thing(
      id: data['id'] as String,
      ownerId: data['owner_id'] as String,
      name: data['name'] as String,
      images: List<String>.from(data['images'] ?? []),
    );
  }
}
