import 'package:flutter/material.dart';
import 'package:nabeey/routes/routes.dart';
import 'package:nabeey/features/explore/screens/home/home.dart';


class AppRoutes{
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ADRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Xato'),
        ),
        body: const Center(
          child: Text('Sahifa topilmadi'),
        ),
      );
    });
  }
}
