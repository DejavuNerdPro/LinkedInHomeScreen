import 'package:flutter/material.dart';

class Network extends StatefulWidget{
  const Network({super.key});

  @override
  State<StatefulWidget> createState() =>NetworkState();
  
}

class NetworkState extends State<Network>{
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('My Network Page.'),);
  }
  
}