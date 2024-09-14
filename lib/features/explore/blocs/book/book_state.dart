import 'package:equatable/equatable.dart';
import 'package:nabeey/features/explore/models/book_model.dart';

abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object> get props => [];
}

class BookLoading extends BookState {}

class BookLoaded extends BookState {
  final List<BookModel> books;

  const BookLoaded(this.books);

  @override
  List<Object> get props => [books];

  @override
  String toString() => 'BookLoaded { Books: $books }';
}

class BookEmpty extends BookState {}

class BookError extends BookState {
  final String message;

  const BookError(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'BookError { message: $message }';
}
