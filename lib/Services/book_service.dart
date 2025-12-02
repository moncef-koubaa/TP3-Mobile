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

  Future<List<Book>> fetchAllBooks() async {
    final list = await _dbHelper.query("SELECT * FROM book");
    return list.map((e) => Book.fromMap(e)).toList();
  }

  Future<int> deleteBookById(int id) async {
    return await _dbHelper.rawDelete("DELETE FROM book WHERE id = ?", [id]);
  }

  Future<int> updateBook(Book book) async {
    final db = await _dbHelper.database;
    return await db.update(
      'book',
      book.toMap(),
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }

  Future<void> clearBasket(String userId) async {
    await _dbHelper.rawDelete("DELETE FROM book WHERE user_id = ?", [userId]);
  }
}
