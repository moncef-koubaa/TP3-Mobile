class Book {
  final int? id;
  final String name;
  final int price;
  final String image;
  final String? userId;

  Book({
    this.id,
    required this.name,
    required this.price,
    required this.image,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'user_id': userId,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] as int?,
      name: map['name'],
      price: map['price'],
      image: map['image'] ?? '',
      userId: map['user_id'],
    );
  }
}
