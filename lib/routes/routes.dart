import 'package:flutter/material.dart';
import '../screens/bookmarks_screen.dart';
import '../screens/communities_screen.dart';
import '../screens/explore_screen.dart';
import '../screens/messages_screen.dart';
import '../screens/notifications_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/resident_feed.dart';

class Routes {
  static const String home = '/';
  static const String explore = '/explore';
  static const String notifications = '/notifications';
  static const String messages = '/messages';
  static const String bookmarks = '/bookmarks';
  static const String communities = '/communities';
  static const String profile = '/profile';

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      home: (context) => const ResidentFeed(),
      explore: (context) => const ExploreScreen(),
      notifications: (context) => const NotificationsScreen(),
      messages: (context) => const MessagesScreen(),
      bookmarks: (context) => const BookmarksScreen(),
      communities: (context) => const CommunitiesScreen(),
      profile: (context) => const ProfileScreen(),
    };
  }

  static void navigateTo(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }
}
