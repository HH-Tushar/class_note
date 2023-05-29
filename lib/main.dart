import 'package:class_note/ui/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/storage.dart';
import 'operations/operations.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
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

          primarySwatch: Colors.green,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

