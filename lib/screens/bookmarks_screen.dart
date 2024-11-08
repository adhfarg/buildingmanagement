import 'package:flutter/material.dart';
import '../widgets/custom_navigation_drawer.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logo.png',
          height: 150,
          fit: BoxFit.contain,
        ),
        backgroundColor: Colors.black,
        toolbarHeight: 160,
      ),
      drawer: const CustomNavigationDrawer(),
      body: const Center(
        child: Text(
          'Bookmarks Screen',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}