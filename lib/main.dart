import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list_with_youtube_video/pages/home_page.dart';

void main() async {
  // init the hive
  await Hive.initFlutter();

  // open box
  var box = await Hive.openBox('todoBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
