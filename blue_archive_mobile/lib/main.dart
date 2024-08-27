import 'package:flutter/material.dart';

import 'character.dart';
import 'favorites.dart'; // Import untuk layar game tebak-menebak

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Si Arsip Biru',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent,
          elevation: 4, // Shadow effect
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey[300],
          indicator: BoxDecoration(
            color: Colors.blue[700],
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        scaffoldBackgroundColor: Colors.blueGrey[50],
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black54),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: DefaultTabController(
        length: 3, // Jumlah tab
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Blue Archive'),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.person), text: 'Characters'),
                Tab(icon: Icon(Icons.favorite), text: 'Favorites'),
              ],
              indicatorSize: TabBarIndicatorSize.label,
            ),
          ),
          body:  TabBarView(
            children: [
              CharacterScreen(),
              FavoritesScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
