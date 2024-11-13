import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/resident_feed.dart';
import 'screens/explore_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/messages_screen.dart';
import 'screens/bookmarks_screen.dart';
import 'screens/communities_screen.dart';
import 'screens/profile_screen.dart';
import 'models/post_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
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
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ResidentFeed(),
        '/explore': (context) => const ExploreScreen(),
        '/notifications': (context) => const NotificationsScreen(),
        '/messages': (context) => const MessagesScreen(),
        '/bookmarks': (context) => const BookmarksScreen(),
        '/communities': (context) => const CommunitiesScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
