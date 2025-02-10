import 'package:flutter/material.dart';
import 'home.dart';
import 'summary.dart';
import 'models/driver.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CarPoolin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomeScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == '/summary') {
          // Recibimos los parámetros desde 'arguments'
          final args = settings.arguments as Map<String, dynamic>;
          final driver = args['driver'] as Driver;
          final fromLocation = args['fromLocation'] as String;
          final toLocation = args['toLocation'] as String;

          return MaterialPageRoute(
            builder: (context) => SummaryScreen(
              driver: driver,
              fromLocation: fromLocation,
              toLocation: toLocation,
            ),
          );
        }
        return null;
      },
    );
  }
}
