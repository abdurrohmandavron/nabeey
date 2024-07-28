import 'package:flutter/material.dart';
import 'package:nabeey/common/widgets/appbar/appbar.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:nabeey/features/explore/models/book_model.dart';
import 'package:nabeey/features/explore/screens/book/widgets/book_tile.dart';

class BookContent extends StatelessWidget {
  const BookContent({super.key, required this.book});

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ADAppBar(title: Text(book.title, style: Theme.of(context).textTheme.titleMedium), showBackArrow: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            /// Book Tile
            BookTile(book: book),
            const SizedBox(height: ADSizes.spaceBtwItems),

            /// Description
            Text(book.description, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: ADSizes.spaceBtwItems),

            /// Content
            SizedBox(
              height: 500,
              width: double.infinity,
              child: SfPdfViewer.network(book.file.filePath),
            ),
          ],
        ),
      ),
    );
  }
}
