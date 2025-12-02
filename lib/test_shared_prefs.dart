import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp3/Models/User.dart';
import 'package:tp3/Services/UserService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final userService = UserService();

  print("=== TEST SHARED PREFERENCES ===");

  // 1. Créer un user
  User user = User(id: "123", name: "Moncef", email: "moncef@test.com");

  // 2. Sauvegarder
  await userService.saveCurrentUser(user);
  print("Utilisateur sauvegardé !");

  // 3. Charger
  User? loaded = await userService.getCurrentUser();
  print("Utilisateur chargé depuis SharedPreferences :");
  print(loaded?.toMap());

  // 4. Supprimer
  await userService.clearCurrentUser();
  print("Utilisateur supprimé !");
}
