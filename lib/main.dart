import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revision/core/dependency_injection/injection.dart';
import 'package:revision/presentation/cubit/cubit/anime_shows_cubit.dart';
import 'package:revision/presentation/screens/anime_shows_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  await initializeDependencies();

  runApp(
    BlocProvider(create: (context) => sl<AnimeShowsCubit>(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime Shows',
      theme: ThemeData(
        popupMenuTheme: PopupMenuThemeData(
          color: Colors.deepPurpleAccent.shade100,
        ),
        primaryColor: Colors.deepPurple,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurpleAccent,
          elevation: 2,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          actionsIconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: AnimeShowsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
