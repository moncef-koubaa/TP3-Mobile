import 'package:flutter/material.dart';
import '../Models/Book.dart';

class HomeTestScreen extends StatelessWidget {
  const HomeTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final testBook = Book(
      name: "Flutter Book",
      price: 30,
      image: "https://via.placeholder.com/150",
    );

    const userId = "user_123"; // un user test

    return Scaffold(
      appBar: AppBar(title: const Text("Test Achat")),
      body: Center(
        child: ElevatedButton(
          child: const Text("Go to product"),
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/product',
              arguments: {'book': testBook, 'userId': userId},
            );
          },
        ),
      ),
    );
  }
}
