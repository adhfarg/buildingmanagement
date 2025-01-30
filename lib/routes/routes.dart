import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/explore_screen.dart';
import '../screens/notifications_screen.dart';
import '../screens/messages_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/forgot_password_screen.dart';

class Routes {
  static const String home = '/';
  static const String explore = '/explore';
  static const String notifications = '/notifications';
  static const String messages = '/messages';
  static const String profile = '/profile';
  static const String login = '/login';
  static const String signUp = '/signup';
  static const String forgotPassword = '/forgot-password';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const HomeScreen(),
      explore: (context) => const ExploreScreen(),
      notifications: (context) => const NotificationsScreen(),
      messages: (context) => const MessagesScreen(),
      profile: (context) => const ProfileScreen(),
      login: (context) => const LoginScreen(),
      signUp: (context) => const SignUpScreen(),
      forgotPassword: (context) => const ForgotPasswordScreen(),
    };
  }

  static void navigateTo(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }
}
