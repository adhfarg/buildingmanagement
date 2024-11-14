import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/post_model.dart';
import 'models/message_model.dart';
import 'routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PostModel()),
        ChangeNotifierProvider(create: (context) => MessageModel()),
      ],
      child: MaterialApp(
        title: 'Building Management',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          cardColor: Colors.grey[900],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[900],
            elevation: 0,
          ),
        ),
        initialRoute: Routes.home,
        routes: Routes.getRoutes(),
      ),
    );
  }
}
