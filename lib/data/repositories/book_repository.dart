import '../../utils/constants/api_constants.dart';
import '../../features/explore/models/book_model.dart';

import 'base_repository.dart';

class BookRepository extends BaseRepository<BookModel> {
  @override
  BookModel fromJson(Map<String, dynamic> json) => BookModel.fromJson(json);

  @override
  BookModel empty() => BookModel.empty();

  Future<List<BookModel>> getBooks() => getAll(ADAPIs.booksR);

  Future<BookModel> getBook(int bookId) => getById(ADAPIs.bookR, bookId);

  Future<BookModel> createBook(BookModel book) => create(ADAPIs.bookC, book.toJson());

  Future<BookModel> updateBook(int bookId, BookModel newBook) => update(ADAPIs.bookU, bookId, newBook.toJson());

  Future<void> deleteBook(int bookId) => delete(ADAPIs.bookD, bookId);
}
