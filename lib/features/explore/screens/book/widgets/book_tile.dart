import 'package:flutter/material.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:nabeey/features/explore/models/book_model.dart';
import 'package:nabeey/common/widgets/images/rounded_image.dart';

class BookTile extends StatelessWidget {
  const BookTile({super.key, required this.book});

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Image
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: Colors.grey, style: BorderStyle.solid),
          ),
          child: RoundedImage(
            borderRadius: 20,
            width: 121,
            fit: BoxFit.cover,
            height: 148,
            isNetworkImage: true,
            imageUrl: book.image.filePath,
            margin: const EdgeInsets.all(20),
          ),
        ),
        const SizedBox(width: ADSizes.spaceBtwItems),

        /// Title & Author
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                book.title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                book.author,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        )
      ],
    );
  }
}
