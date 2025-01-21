import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../common/widgets/headers/header.dart';
import '../../../../utils/helpers/check_bloc_state.dart';
import '../../../../features/explore/models/book_model.dart';
import '../../../../features/explore/blocs/base/base_bloc.dart';
import '../../../../features/explore/blocs/base/base_state.dart';
import '../../../../data/models/category_model.dart';
import '../../../../features/explore/screens/book/widgets/book_item.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// Category Description
          ADHeader(category: category),

          /// Books
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BlocBuilder<BaseBloc<BookModel>, BaseState>(
                builder: (context, state) {
                  return CheckBlocState.checkState(context, state) ??
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: (state as ItemsLoaded).items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: ADSizes.defaultSpace),
                        itemBuilder: (context, index) {
                          final BookModel book = state.items[index];
                          return BookItem(book: book);
                        },
                      );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
