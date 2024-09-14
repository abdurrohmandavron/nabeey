import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/utils/exceptions/exceptions.dart';
import 'package:nabeey/data/repositories/book_repository.dart';

import 'book_event.dart';
import 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepositoryImpl bookRepository = BookRepositoryImpl();

  BookBloc() : super(BookLoading()) {
    on<LoadBooks>((event, emit) async {
      try {
        final books = await bookRepository.getBooks();
        emit(BookLoaded(books));
      } on SocketException {
        emit(const BookError("Server bilan bog'lanib bo'lmadi."));
      } catch (e) {
        ADException(e);
        emit(BookError('BookError: $e'));
      }
    });
  }
}
