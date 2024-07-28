import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/utils/exceptions/exceptions.dart';
import 'package:nabeey/data/repositories/book_repository.dart';
import 'package:nabeey/features/explore/models/book_model.dart';

class BookController extends Bloc<BookEvent, BookState> {
  final BookRepositoryImpl bookRepository = BookRepositoryImpl();

  BookController() : super(const BookLoading()) {
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

// BookEvent represents events that the BookBloc can react to
abstract class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object> get props => [];
}

class LoadBooks extends BookEvent {
  const LoadBooks();

  @override
  String toString() => 'LoadBooks';
}

// BookState represents the state of the BookBloc
abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object> get props => [];
}

class BookLoading extends BookState {
  const BookLoading();

  @override
  String toString() => 'BookLoading';
}

class BookLoaded extends BookState {
  final List<BookModel> books;

  const BookLoaded(this.books);

  @override
  List<Object> get props => [books];

  @override
  String toString() => 'BookLoaded { Books: $books }';
}

class BookEmpty extends BookState {
  const BookEmpty();

  @override
  String toString() => 'BookEmpty';
}

class BookError extends BookState {
  final String message;

  const BookError(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'BookError { message: $message }';
}
