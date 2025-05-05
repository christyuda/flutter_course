class ProductEntity {
  final String id;
  final String name;
  final String description;
  final String category;
  final double price;
  final String? imageUrl;

  ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    this.imageUrl,
  });

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      price: (json['price'] is int) ? (json['price'] as int).toDouble() : json['price'],
      imageUrl: json['imageUrl'] as String?,
    );
  }

  /// ✅ tambahkan ini biar bisa ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
