import 'package:flutter/material.dart';
import 'package:nabeey/routes/app_routes.dart';
import 'package:nabeey/utils/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/common/navigation/views/navigation_menu.dart';
import 'package:nabeey/features/explore/blocs/category/category_bloc.dart';
import 'package:nabeey/common/navigation/viewmodels/navigation_controller.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Nabeey App",
      theme: ADTheme.lightTheme,
      themeMode: ThemeMode.system,
      darkTheme: ADTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.generateRoute,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<NavigationCubit>(create: (context) => NavigationCubit()),
          BlocProvider<CategoryBloc>(create: (context) => CategoryBloc()),
        ],
        child: const NavigationMenu(),
      ),
    );
  }
}
