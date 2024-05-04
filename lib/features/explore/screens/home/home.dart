import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/features/explore/controllers/category_controller.dart';
import 'package:nabeey/features/explore/screens/home/widgets/category_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<CategoryController>(context);
    controller.add(const LoadCategories());

    return Scaffold(
      appBar: AppBar(title: Text('Nabeey', style: Theme.of(context).textTheme.headlineLarge)),
      body: BlocBuilder<CategoryController, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryLoaded) {
            return ListView.builder(
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final category = state.categories[index];
                return CategoryItem(category: category);
              },
            );
          } else if (state is CategoryError) {
            return Center(
              child: Text('Xato: ${state.message}'),
            );
          } else {
            return const Text('Nimadir xato ketdi!');
          }
        },
      ),
    );
  }
}
