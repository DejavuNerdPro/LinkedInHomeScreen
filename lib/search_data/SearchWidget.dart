import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:linkedin_home/search_data/post.dart';
import 'package:http/http.dart' as http;
import 'package:linkedin_home/search_data/post_list.dart';

class SearchWidget extends StatefulWidget{
  const SearchWidget({super.key});

  @override
  State<StatefulWidget> createState() => _SearchWidgetState();
  
}

class _SearchWidgetState extends State<SearchWidget>{
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('All posts'),
      ),
      backgroundColor: Colors.white,
      body: PostList(posts: posts),
    );
  }
}