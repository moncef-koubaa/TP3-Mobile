import 'package:flutter/material.dart';
import 'package:tp3/Models/Book.dart';
import 'package:tp3/Services/book_service.dart';

/// Représente une ligne (cellule) affichant un Book.
/// - book : l'objet Book à afficher
/// - onDeleted : callback optionnel appelé après que le book a été supprimé de la DB
/// - onTap : callback optionnel pour cliquer sur la ligne (ouvrir détails)
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
            IconButton(
              tooltip: 'Voir',
              icon: const Icon(Icons.open_in_new),
              onPressed: onTap,
            ),
            IconButton(
              tooltip: 'Supprimer',
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () async {
                // sécurité : vérifier que l'id existe
                if (book.id == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Impossible de supprimer : id manquant'),
                    ),
                  );
                  return;
                }

                // confirmation
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Confirmer'),
                    content: const Text(
                      'Voulez-vous supprimer cet article du panier ?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(false),
                        child: const Text('Annuler'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(true),
                        child: const Text('Supprimer'),
                      ),
                    ],
                  ),
                );

                if (confirm != true) return;

                try {
                  await BookService().deleteBookById(book.id!);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Supprimé')));
                  if (onDeleted != null) onDeleted!();
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Erreur: $e')));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeading() {
    if (book.image.isEmpty) return const Icon(Icons.book, size: 48);
    // si c'est un URL distant
    if (book.image.startsWith('http')) {
      return Image.network(
        book.image,
        width: 56,
        height: 56,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
      );
    }
    // sinon on suppose un asset path
    return Image.asset(book.image, width: 56, height: 56, fit: BoxFit.cover);
  }
}
