import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:linkedin_home/MoviesData/movie.dart';
import 'package:linkedin_home/VideoPlayer/online_video_player.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget{
  ScrollController refcontroller;
  Home({super.key,required this.refcontroller});

  @override
  State<StatefulWidget> createState() =>HomeState();
  
}

class HomeState extends State<Home>{
  List<String> title = ['Sparrow', 'Elephant', 'Humming Bird', 'Lion'];
  List<Movie> movies=<Movie>[];

  @override
  void initState(){
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async{
    final response= await http.get(Uri.parse("https://freetestapi.com/api/v1/movies"));

    if(response.statusCode==200){
      print("API is ready........");
      final bodyJson= jsonDecode(response.body)as List;

      if(mounted){
        setState(() {
        movies=bodyJson.map((json) => Movie.fromJson( json as Map<String,dynamic>)).toList();
      });
      print(movies[0]);
      }

    }else{
      print("API not fetch.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
              height: MediaQuery.of(context).size.height-100,
              child: MediaQuery.removePadding(context: context,
              removeTop: true,
              child: ListView.builder(
              controller: widget.refcontroller,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return movies.isNotEmpty? card(movies[index], context): const Card();
              },
            ),),
            );
  }
  
}

Widget card(Movie movie, BuildContext context) {
  return Container(
    color: Colors.white,
    //elevation: 0.0,
    margin: const EdgeInsets.only(top:10.0),
    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
    child: Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
      children: [
        Image.network(movie.poster,width: 50,height: 50,),
        const SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(movie.title,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
        ),
        Text(movie.director,
        textAlign: TextAlign.start,
        style: const TextStyle(
          fontSize: 8,
          color: Colors.grey,
          fontWeight: FontWeight.normal,
        ),
        ),
        Text(movie.production,
        textAlign: TextAlign.start,
        style: const TextStyle(
          fontSize: 8,
          color: Colors.grey,
          fontWeight: FontWeight.normal,
        ),
        ),
          ],
        ),
        const Spacer(),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(icon: const Icon(Icons.more_vert), onPressed: () { 
            _showBottomSheet(context);
          },),
        )

      ],
    ),
    const SizedBox(height: 15,),
    Container(
      decoration: BoxDecoration(
        border:Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8)
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
          const Text("Tomato :",
          textAlign: TextAlign.start,
          style: TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
    ),
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(movie.rating.toInt()<=5? movie.rating.toInt(): movie.rating.toInt()%5+1, (index) => IconButton(
      icon: const Icon(
        size:15,
        Icons.star_border,
        color: Colors.amber,
      ), onPressed: () {  },
    ),
    ),
    )
          ],
        ),
        Text("'${movie.plot}'",
        textAlign: TextAlign.start,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
    ),
    const SizedBox(height: 30,),
    OnlineVideoPlayer(url: movie.trailer),
      ]),
    ),
        ],
      ),
    ),
  );
}

void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Share'),
                onTap: () {
                  // Add your action here
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
              ListTile(
                leading: const Icon(Icons.link),
                title: const Text('Get link'),
                onTap: () {
                  // Add your action here
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit name'),
                onTap: () {
                  // Add your action here
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
            ],
          ),
        );
      },
    );
  }