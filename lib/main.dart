import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'models/post_model.dart';
import 'models/message_model.dart';
import 'routes/routes.dart';

const supabaseUrl = 'https://lytvsfqubqtoghoinukr.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx5dHZzZnF1YnF0b2dob2ludWtyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzgxOTE4MjgsImV4cCI6MjA1Mzc2NzgyOH0.WyFfD_JEb1Xgw0B1hXL7j__4LOpD20rLiVBNe5a81Jo';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

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
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        initialRoute: Routes.login,
        routes: Routes.getRoutes(),
      ),
    );
  }
}
