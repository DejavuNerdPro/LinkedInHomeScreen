import 'package:flutter/material.dart';
import 'package:linkedin_home/search_data/post.dart';
import 'package:linkedin_home/search_data/post_list.dart';

class Search_Delegate extends SearchDelegate{
  Search_Delegate({required this.posts});
  late final List<Post> posts;
  List<Post> results = <Post>[];
  @override
  List<Widget>? buildActions(BuildContext context) =>[
    IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query.isEmpty ? close(context, null) : query = '',
      ),
  ];
  @override
  Widget? buildLeading(BuildContext context) =>IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );

  @override
  Widget buildResults(BuildContext context) =>results.isEmpty
    ? const Center(
        child: Text('No Results', style: TextStyle(fontSize: 24)),
      )
    : PostList(posts: results);

  @override
  Widget buildSuggestions(BuildContext context) {
    results = posts.where((Post post) {
    final String title = post.title.toLowerCase();
    final String body = post.body.toLowerCase();
    final String input = query.toLowerCase();

    return title.contains(input) || body.contains(input);
  }).toList();

  return results.isEmpty
      ? const Center(
          child: Text('No Results', style: TextStyle(fontSize: 24)),
        )
      : PostList(posts: results);
  }
  
}