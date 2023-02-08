import 'package:flutter/material.dart';
import 'package:noticias_provider/src/pages/pages.dart';
import 'package:noticias_provider/src/services/news_service.dart';
import 'package:noticias_provider/src/theme/tema.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsService()),
      ],
      child: MaterialApp(
        title: 'Material App',
        theme: myTheme,
        debugShowCheckedModeBanner: false,
        home: const TabsPage(),
      ),
    );
  }
}
