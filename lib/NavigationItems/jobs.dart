import 'package:flutter/material.dart';

class Jobs extends StatefulWidget{
  const Jobs({super.key});

  @override
  State<StatefulWidget> createState() =>JobsState();

}

class JobsState extends State<Jobs>{
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Post Home'),);
  }
  
}