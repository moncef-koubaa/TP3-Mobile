import 'package:flutter/material.dart';
import 'Models/Book.dart';
import './Screens/some_product_screen.dart';
import './Screens/basket_screen.dart';
import './Screens/home_test_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeTestScreen(),
        '/product': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map;
          return SomeProductScreen(book: args['book'], userId: args['userId']);
        },
        '/basket': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map;
          return BasketScreen();
        },
      },
    );
  }
}
