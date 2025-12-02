import 'package:flutter/material.dart';
import '../Models/Book.dart';
import '../Services/book_service.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  Future<List<Book>> fetchBasket(String? userId) async {
    if (userId == null) return <Book>[];
    return await BookService().fetchBasketBooks(userId);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final Map<String, dynamic> mapArgs = args != null
        ? args as Map<String, dynamic>
        : {};
    final String? userId = mapArgs['userId'];

    return Scaffold(
      appBar: AppBar(title: const Text("Panier")),
      body: FutureBuilder<List<Book>>(
        future: fetchBasket(userId), // type bien défini ici

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final books = snapshot.data!;
          if (books.isEmpty) {
            return const Center(child: Text("Le panier est vide"));
          }

          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (_, index) => HomeCell(books[index]),
          );
        },
      ),
    );
  }
}

// Widget de démonstration pour afficher un livre
class HomeCell extends StatelessWidget {
  final Book book;
  const HomeCell(this.book, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(book.name),
      subtitle: Text("Prix: ${book.price}"),
      leading: book.image.isNotEmpty
          ? Image.network(book.image, width: 50, height: 50)
          : null,
    );
  }
}
