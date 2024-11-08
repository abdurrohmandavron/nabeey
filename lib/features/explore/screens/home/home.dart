import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:nabeey/utils/constants/colors.dart';
import 'package:nabeey/features/quiz/screens/quiz.dart';
import 'package:nabeey/utils/helpers/helper_functions.dart';
import 'package:nabeey/features/explore/cubits/navigation/navigation_cubit.dart';

import '../category/category.dart';
import 'widgets/navigation_bar.dart';
import '../../blocs/base/base_bloc.dart';
import '../../../../bindings/service_locator.dart';
import '../../models/category_model.dart';
import '../../models/navigation_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Builder(builder: (context) {
        final cubit = BlocProvider.of<HomeCubit>(context);

        return Scaffold(
          // TODO
          bottomNavigationBar: kDebugMode
              ? BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return ADNavigationBar(
                      height: 60,
                      radius: 30.0,
                      color: ADColors.white,
                      selectedIndex: state.index,
                      selectedItemColor: const Color(0xFFF59C16),
                      unselectedItemColor: dark ? ADColors.white : const Color.fromRGBO(17, 17, 17, 0.5),
                      onDestinationSelected: cubit.onDestinationSelected,
                      destinations: const [
                        NavigationModel(icon: Icon(Feather.home), label: "Asosiy"),
                        NavigationModel(icon: Icon(Feather.help_circle), label: "Test"),
                        NavigationModel(icon: Icon(Feather.activity), label: "Reyting"),
                        NavigationModel(icon: Icon(Feather.user), label: "Profil"),
                      ],
                    );
                  },
                )
              : const SizedBox(),
          body: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return [
                BlocProvider<BaseBloc<CategoryModel>>(
                  create: (context) => getIt<BaseBloc<CategoryModel>>(),
                  child: const CategoryScreen(),
                ),
                const QuizScreen(),
                Container(color: Colors.blue),
                Container(color: Colors.green),
              ][state.index];
            },
          ),
        );
      }),
    );
  }
}
