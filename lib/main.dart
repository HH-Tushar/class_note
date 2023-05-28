import 'package:class_note/ui/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'operations.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => (SubjectOperation())),
        ChangeNotifierProvider(create: (_) => (TopicOperation())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

