import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:linkedin_home/main_screen.dart';
import 'package:linkedin_home/search_data/post.dart';

void main() {
  runApp(const ProviderScope(child: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Linkedin',
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Linked'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  List<Post> posts = <Post>[];

  @override
  void initState() {
    super.initState();

    _getPosts();
  }

  

  Future<void> _getPosts() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      final bodyJson = jsonDecode(response.body) as List;

      setState(() => posts = bodyJson
          .map((json) => Post.fromJson(json as Map<String, dynamic>))
          .toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(posts: posts);
  }

}

