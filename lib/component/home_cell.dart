import 'package:flutter/material.dart';
import '../Models/Book.dart';
import '../Services/book_service.dart';

class HomeCell extends StatelessWidget {
  final Book book;
  final VoidCallback? onDeleted;
  final VoidCallback? onTap;

  const HomeCell(this.book, {Key? key, this.onDeleted, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        leading: _buildLeading(),
        title: Text(book.name, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(
          '${book.price} DT' + (book.userId != null ? ' • ${book.userId}' : ''),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: const Icon(Icons.open_in_new), onPressed: onTap),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () async {
                if (book.id == null) return;
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Confirmer'),
                    content: const Text(
                      'Voulez-vous supprimer cet article du panier ?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Annuler'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Supprimer'),
                      ),
                    ],
                  ),
                );
                if (confirm != true) return;
                await BookService().deleteBookById(book.id!);
                if (onDeleted != null) onDeleted!();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeading() {
    if (book.image.isEmpty) return const Icon(Icons.book, size: 48);
    if (book.image.startsWith('http')) {
      return Image.network(
        book.image,
        width: 56,
        height: 56,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
      );
    }
    return Image.asset(book.image, width: 56, height: 56, fit: BoxFit.cover);
  }
}
