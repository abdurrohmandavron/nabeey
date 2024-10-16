import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../features/explore/models/book_model.dart';
import '../../../../features/explore/screens/book/widgets/book_tile.dart';

class BookContent extends StatelessWidget {
  const BookContent({super.key, required this.book});

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ADAppBar(title: Text(book.title, style: Theme.of(context).textTheme.titleMedium), showBackArrow: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            ListView(
              children: [
                /// Book Tile
                BookTile(book: book),
                const SizedBox(height: ADSizes.spaceBtwItems),

                /// Description
                Text(book.description, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: ADSizes.spaceBtwItems),
              ],
            ),

            /// Content
            Positioned(
              bottom: 0,
              right: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SizedBox(
                        height: 850,
                        width: double.infinity,
                        child: SfPdfViewer.network(book.file.filePath),
                      ),
                    ),
                  ),
                  child: const Text("O'qish"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
