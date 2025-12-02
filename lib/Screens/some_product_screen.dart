import 'package:flutter/material.dart';
import '../Models/Book.dart';
import '../Services/book_service.dart';

class SomeProductScreen extends StatelessWidget {
  final Book book;
  final String userId;

  const SomeProductScreen({
    super.key,
    required this.book,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book.name)),
      body: Center(
        child: ElevatedButton(
          child: const Text("Purchase"),
          onPressed: () async {
            final bookToInsert = Book(
              name: book.name,
              price: book.price,
              image: book.image,
              userId: userId,
            );

            try {
              await BookService().addBook(bookToInsert);

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Ajouté au panier")));

              Navigator.pushNamed(
                context,
                "/basket",
                arguments: {'userId': userId}, // navigation sécurisée
              );
            } catch (e) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Erreur : $e")));
            }
          },
        ),
      ),
    );
  }
}
