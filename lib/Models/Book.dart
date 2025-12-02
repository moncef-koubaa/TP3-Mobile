class Book {
  int? id; // null avant insertion
  final String name;
  final int price;
  final String image;
  final String? userId; // nullable : un livre peut être non lié à un user

  Book({
    this.id,
    required this.name,
    required this.price,
    required this.image,
    this.userId,
  });

  // pour insertion
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'price': price,
      'image': image,
      'user_id': userId,
    };
    if (id != null) map['id'] = id;
    return map;
  }

  // depuis la DB
  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] as int?,
      name: map['name'] as String,
      price: map['price'] as int,
      image: map['image'] as String,
      userId: map['user_id'] as String?,
    );
  }
}
