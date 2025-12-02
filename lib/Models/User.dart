class User {
  final String id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  // Pour sauvegarder dans SharedPreferences
  Map<String, String> toMap() {
    return {"id": id, "name": name, "email": email};
  }

  // Pour reconstruire depuis SharedPreferences
  factory User.fromMap(Map<String, dynamic> map) {
    return User(id: map["id"], name: map["name"], email: map["email"]);
  }
}
