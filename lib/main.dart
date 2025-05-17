import 'package:flutter/material.dart';
import 'package:control_gastos/screens/home_screen.dart';

void main() {
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control de Gastos', 
      theme: ThemeData(
  scaffoldBackgroundColor: const Color(0xFFF3E5F5), // Fondo #F3E5F5
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black), // Texto principal negro
    bodyMedium: TextStyle(color: Colors.black), // Texto secundario negro
    titleLarge: TextStyle(color: Colors.black), // Títulos negros
  ),
  primarySwatch: Colors.teal, // Color primario (puedes ajustarlo)
),
      home: const HomeScreen(),
    );
  }
}
