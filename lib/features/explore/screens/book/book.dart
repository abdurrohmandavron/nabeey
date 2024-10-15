import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:nabeey/common/widgets/header/header.dart';
import 'package:nabeey/features/explore/models/book_model.dart';
import 'package:nabeey/features/explore/blocs/base/base_bloc.dart';
import 'package:nabeey/features/explore/blocs/base/base_state.dart';
import 'package:nabeey/features/explore/models/category_model.dart';
import 'package:nabeey/features/explore/screens/book/widgets/book_item.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BaseBloc<BookModel>, BaseState>(
        builder: (context, state) {
          if (state is ItemsInit) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ItemsLoaded) {
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
                      itemCount: state.items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: ADSizes.defaultSpace),
                      itemBuilder: (context, index) {
                        final BookModel book = state.items[index];
                        return BookItem(book: book);
                      },
                    ),
                  ),
                )
              ],
            );
          } else if (state is ItemsError || state is ItemsEmpty) {
            return Center(child: Padding(padding: const EdgeInsets.all(ADSizes.defaultSpace), child: Text(state.toString(), style: Theme.of(context).textTheme.bodyLarge)));
          } else {
            return Center(child: Padding(padding: const EdgeInsets.all(ADSizes.defaultSpace), child: Text("Noma'lum xatolik.", style: Theme.of(context).textTheme.bodyLarge)));
          }
        },
      ),
    );
  }
}
