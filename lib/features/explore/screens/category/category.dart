import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:nabeey/features/explore/blocs/base/base_bloc.dart';
import 'package:nabeey/features/explore/blocs/base/base_state.dart';
import 'package:nabeey/data/models/category_model.dart';
import 'package:nabeey/common/widgets/shimmers/category_item_shimmer.dart';
import 'package:nabeey/features/explore/screens/category/widgets/category_item.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nabeey', style: Theme.of(context).textTheme.headlineLarge)),
      body: BlocBuilder<BaseBloc<CategoryModel>, BaseState>(
        builder: (context, state) {
          if (state is ItemsLoading) {
            return Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(
                itemCount: 4,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) => const CategoryItemShimmer(),
              ),
            );
          } else if (state is ItemsLoaded) {
            return Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final category = state.items[index];
                  return CategoryItem(category: category);
                },
              ),
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
