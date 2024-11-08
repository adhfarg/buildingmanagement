import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/resident_feed.dart';
import 'models/post_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PostModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Building Management',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.blue,
      ),
      home: const ResidentFeed(),
    );
  }
}
