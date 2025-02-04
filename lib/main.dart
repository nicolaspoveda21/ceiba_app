import 'package:flutter/material.dart';
import 'package:flutter_application/core/app_theme/app_theme.dart';
import 'package:flutter_application/core/navigation/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prueba de Ingreso',
      theme: AppTheme.theme,
      initialRoute: AppRoutes.userListScreen,
      routes: AppRoutes.routes,
    );
  }
}
