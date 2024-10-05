import 'package:nabeey/data/repositories/book_repository.dart';

import '../base/base_bloc.dart';

import 'book_event.dart';
import 'book_state.dart';

class BookBloc extends BaseBloc<BookEvent, BookState> {
  final BookRepository bookRepository;

  BookBloc(this.bookRepository) : super(BookLoading()) {
    on<LoadBooks>((event, emit) async {
      try {
        final books = await bookRepository.getBooks();
        emit(BookLoaded(books));
      } catch (e) {
        handleError(emit, e);
      }
    });
  }
}
