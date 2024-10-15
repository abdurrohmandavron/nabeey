import 'package:flutter/material.dart';

import 'routes/app_routes.dart';
import 'utils/theme/theme.dart';
import 'features/explore/screens/home/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Nabeey",
      theme: ADTheme.lightTheme,
      themeMode: ThemeMode.system,
      darkTheme: ADTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.generateRoute,
      home: const HomeScreen(),
    );
  }
}
