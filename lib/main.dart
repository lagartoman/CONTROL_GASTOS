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
      theme: ThemeData(// Color de fondo global
        scaffoldBackgroundColor: const Color.fromARGB(255, 143, 117, 228), // Fondo claro
        // Tema de texto global
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color.fromARGB(221, 199, 248, 4)), // Texto principal
          bodyMedium: TextStyle(color: Color.fromARGB(157, 101, 250, 2)), // Texto secundario
        ),
        // Color primario (botones, AppBar, etc.)
        primarySwatch: Colors.teal,
      ),
      home: const HomeScreen(),
    );
  }
}
