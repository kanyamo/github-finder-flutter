import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/github_repositories_provider.dart';
import 'screens/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GitHubRepositoriesProvider(),
      child: MaterialApp(
        title: 'GitHub Repository Search',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const SearchScreen(),
      ),
    );
  }
}
