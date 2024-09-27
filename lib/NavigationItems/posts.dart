import 'package:flutter/material.dart';

class Posts extends StatefulWidget{
  const Posts({super.key});

  @override
  State<StatefulWidget> createState() =>PostsState();
  
}

class PostsState extends State<Posts>{
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Post Home'),);
  }
  
}