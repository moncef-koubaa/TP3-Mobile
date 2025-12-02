import '../Models/Book.dart';
import '../database_helper.dart';

class BookService {
  final _dbHelper = DatabaseHelper.instance;

  Future<void> addBook(Book book) async {
    await _dbHelper.insert('book', book.toMap());
    print("Book added!");
  }

  Future<List<Book>> fetchBasketBooks(String userId) async {
    final list = await _dbHelper.query("SELECT * FROM book WHERE user_id = ?", [
      userId,
    ]);

    return list.map((e) => Book.fromMap(e)).toList();
  }
}
