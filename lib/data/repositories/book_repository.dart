import 'package:flutter/material.dart';
import 'package:nabeey/utils/http/http_client.dart';
import 'package:nabeey/utils/constants/api_constants.dart';
import 'package:nabeey/features/explore/models/book_model.dart';

abstract class BookRepository {
  @protected
  Future<List<BookModel>> getBooks();

  Future<BookModel?> getBook(int bookId);

  Future<void> createBook(BookModel book);

  Future<void> updateBook(BookModel book);

  Future<void> deleteBook(int bookId);
}

class BookRepositoryImpl implements BookRepository {
  final HttpHelper _httpClient = HttpHelper();

  BookRepositoryImpl();

  @override
  Future<List<BookModel>> getBooks() async {
    final response = await _httpClient.get(ADAPIs.booksR);
    final List<dynamic> bookListJson = response['data'];
    final List<BookModel> books = bookListJson.map((bookJson) => BookModel.fromJson(bookJson)).toList();
    return books;
  }

  @override
  Future<BookModel?> getBook(int bookId) async {
    final response = await _httpClient.get(ADAPIs.bookR);
    // Handle API response (error checking, data parsing)
    return response['data'] != null ? BookModel.fromJson(response['data']) : null;
  }

  @override
  Future<void> createBook(BookModel book) async {
    // Send create Book request to API
    await _httpClient.post(ADAPIs.bookC, book.toJson());
  }

  @override
  Future<void> updateBook(BookModel book) async {
    // Send update Book request to API
    await _httpClient.put(ADAPIs.bookU + book.id.toString(), book.toJson());
  }

  @override
  Future<void> deleteBook(int bookId) async {
    // Send delete Book request to API
    await _httpClient.delete(ADAPIs.bookD + bookId.toString());
  }
}
