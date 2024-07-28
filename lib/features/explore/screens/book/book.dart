import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:nabeey/common/widgets/header/header.dart';
import 'package:nabeey/features/explore/models/category_model.dart';
import 'package:nabeey/features/explore/controllers/book_controller.dart';
import 'package:nabeey/features/explore/screens/book/widgets/book_item.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<BookController>(context);
    controller.add(const LoadBooks());

    return Scaffold(
      body: BlocBuilder<BookController, BookState>(
        builder: (context, state) {
          if (state is BookLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookLoaded) {
            return Column(
              children: [
                /// Category Description
                ADHeader(category: category),

                /// Books
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: state.books.length,
                      separatorBuilder: (_, __) => const SizedBox(height: ADSizes.defaultSpace),
                      itemBuilder: (context, index) {
                        final book = state.books[index];
                        return BookItem(book: book);
                      },
                    ),
                  ),
                )
              ],
            );
          } else if (state is BookEmpty) {
            return Center(child: Padding(padding: const EdgeInsets.all(ADSizes.defaultSpace), child: Text("Kitoblar mavjud emas.", style: Theme.of(context).textTheme.bodyLarge)));
          } else if (state is BookError) {
            return Center(child: Padding(padding: const EdgeInsets.all(ADSizes.defaultSpace), child: Text(state.message, style: Theme.of(context).textTheme.bodyLarge)));
          } else {
            return Center(child: Padding(padding: const EdgeInsets.all(ADSizes.defaultSpace), child: Text("Nimadir xato ketdi.", style: Theme.of(context).textTheme.bodyLarge)));
          }
        },
      ),
    );
  }
}
