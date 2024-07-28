import 'package:flutter/material.dart';
import 'package:nabeey/features/explore/models/book_model.dart';
import 'package:nabeey/features/explore/screens/book/book_content.dart';
import 'package:nabeey/features/explore/screens/book/widgets/book_tile.dart';

class BookItem extends StatelessWidget {
  const BookItem({super.key, required this.book});

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return BookContent(book: book);
          }),
        );
      },
      child: BookTile(book: book),
    );
  }
}
