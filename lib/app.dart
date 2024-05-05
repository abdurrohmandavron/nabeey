import 'package:flutter/material.dart';
import 'package:nabeey/navigation_menu.dart';
import 'package:nabeey/routes/app_routes.dart';
import 'package:nabeey/utils/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/features/explore/controllers/category_controller.dart';

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
      home: MultiBlocProvider(
        providers: [
          BlocProvider<NavigationCubit>(create: (context) => NavigationCubit()),
          BlocProvider<CategoryController>(create: (context) => CategoryController()),
        ],
        child: const NavigationMenu(),
      ),
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
